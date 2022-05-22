class DiscordApi
    include HTTParty

    base_uri 'https://discord.com/api'

    TSRP_DISCORD_ID = '564839968946520064'

    def initialize(token: )
        @token = token
        @last  = nil
    end

    def guilds
        @guilds ||= fetch("/users/@me/guilds")
    end

    def is_tsrp_member?
        if guilds.find { |i| String(i['id']) == TSRP_DISCORD_ID }
            return true
        else
            return false
        end
    end

    private

    def fetch(path)
        @last = self.class.get(path, {
            headers: { "Authorization" => "Bearer #{@token}" }
        })

        Rails.logger.info("Fetching from Discord: #{path}. Response = #{@last.code}.")

        JSON.parse(@last.body)
    end
end
