# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.0
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# 開発に必要なパッケージをインストール（build-essentialなどは開発で必須）
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    libpq-dev \
    libvips \
    postgresql-client \
    git \
    pkg-config \
    libyaml-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# ★ここを development に変更！
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# 開発時は「本番専用」の設定をオフにする
# BUNDLE_DEPLOYMENT="1" と BUNDLE_WITHOUT="development" を削除しました

FROM base AS build

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# 最終ステージ
FROM base

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# 権限設定
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
# ★ bundle exec をつけて確実に Rails を起動
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]