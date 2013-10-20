# -*- coding: utf-8 -*-
class GithubChecker
  require 'json'
  require 'open-uri'

  attr_accessor :user, :access_token

  class << self
    def check(repos, opts={})
      new(opts).fetch repos
    end

    def check_with_message(repos, opts={})
      output = []
      pulls = check(repos, opts)
      output << Messages.opening
      output << pulls.map {|pull| Messages.pr pull }
      output << Messages.closing(pulls.size)
      output.join("\n")
    end
  end

  def initialize(opts={})
    @user = opts[:user]
    @access_token = opts[:access_token]
  end

  def fetch(repos)
    repos.map {|repo| fetch_pulls repo }.flatten.compact
  end

  private
  def fetch_pulls(repo)
    # [ToDo] optionize basic_authnetication
    JSON.parse open("https://api.github.com/repos/#{repo}/pulls", http_basic_authentication: [user, access_token], ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read
  end

  module Messages
    # [ToDo] use message catalog
    class << self
      require 'action_view'
      include ActionView::Helpers::DateHelper

      def animal
        %w|🐶 🐺 🐱 🐭 🐹 🐰 🐸 🐯 🐨 🐻 🐷 🐮 🐼 🐧 🐦 🐤 🐣 🐔 🐙 🐬 🐳|.sample
      end

      def opening
        "#{animal} PR ちぇっ〜く！"
      end

      def closing(counter)
        if counter == 0
          "#{animal} PR はありませんでした！🍻🍻🍻"
        else
          "#{animal} PR が #{counter} 個あったよ！レビューしてね♪"
        end
      end

      def pr(pull)
        "【#{pull['head']['repo']['full_name']}】#{pr_title(pull['title'], pull['created_at'])}\n#{pr_url(pull['html_url'])}"
      end

      def pr_title(title, created_at)
        "#{title} [#{distance_of_time_in_words_to_now(Time.parse created_at)}]"
      end

      def pr_url(url)
        "　➡ #{url}"
      end
    end
  end
end
