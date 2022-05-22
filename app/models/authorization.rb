require 'discord_api'

class Authorization < ApplicationRecord
  belongs_to :user

  def can_register?
    if self.provider != "discord" then
      return true
    end

    return discord.is_tsrp_member?
  end

  private

  def discord
    @discord = DiscordApi.new(token: self.token)
  end
end
