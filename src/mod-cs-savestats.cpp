
  #include "Chat.h"
  #include "Player.h"
  #include "ScriptMgr.h"
  #include "CharacterDatabase.h"
  #include "World.h"
  #include "SharedDefines.h"  using namespace Acore::ChatCommands;
  #include "ChatCommandHelpers.h" // ChatCommandBuilder 정의를 포함하는 헤더 파일 추가
  #include "ObjectAccessor.h" // ObjectAccessor 헤더 파일 포함


class CS_SaveStats : public CommandScript
{
public:
    CS_SaveStats() : CommandScript("CS_SaveStats") {}

        std::vector<Acore::ChatCommands::ChatCommandBuilder> GetCommands() const override
        {
            return {}; // No commands registered
        }
    static void SavePlayerStatsToDB(Player* player)
    {
        if (!player)
            return;

        uint32 guid = player->GetGUID().GetCounter();
        uint32 strength = player->GetStat(STAT_STRENGTH);
        uint32 agility = player->GetStat(STAT_AGILITY);
        uint32 stamina = player->GetStat(STAT_STAMINA);
        uint32 intellect = player->GetStat(STAT_INTELLECT);
        uint32 spirit = player->GetStat(STAT_SPIRIT);
        uint32 health = player->GetMaxHealth();
        uint32 mana = player->GetMaxPower(POWER_MANA);
        uint32 attackPower = player->GetTotalAttackPowerValue(BASE_ATTACK);
        int32 spellPower = player->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS); /* 주문력 */
        uint32 armor = player->GetArmor();

        CharacterDatabase.Execute("INSERT INTO custom_character_stats (guid, strength, agility, stamina, intellect, spirit, health, mana, attack_power, spell_power, armor) VALUES ({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}) ON DUPLICATE KEY UPDATE strength = VALUES(strength), agility = VALUES(agility), stamina = VALUES(stamina), intellect = VALUES(intellect), spirit = VALUES(spirit), health = VALUES(health), mana = VALUES(mana), attack_power = VALUES(attack_power), spell_power = VALUES(spell_power), armor = VALUES(armor);", guid, strength, agility, stamina, intellect, spirit, health, mana, attackPower, spellPower, armor);
        // No handler to send message, so no message sent to player
    }
};

class mod_cs_savestats_PlayerScript : public PlayerScript
{
public:
    mod_cs_savestats_PlayerScript() : PlayerScript("mod_cs_savestats_PlayerScript") {}

    void OnPlayerLogout(Player* player) override
    {
        CS_SaveStats::SavePlayerStatsToDB(player);
    }
};

// 모듈 로딩 시 호출될 진입 함수
void Addmod_cs_savestatsScripts()
{
    new CS_SaveStats(); // CommandScript (now without commands)
    new mod_cs_savestats_PlayerScript(); // PlayerScript for logout save
}
