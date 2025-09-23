-- custom_character_stats 테이블이 없으면 생성합니다. 이 구문은 여러 번 실행해도 안전합니다.
  CREATE TABLE IF NOT EXISTS custom_character_stats (
    guid INT(10) UNSIGNED NOT NULL COMMENT 'Character Global Unique Identifier',
    strength INT(10) UNSIGNED NOT NULL DEFAULT '0',
    agility INT(10) UNSIGNED NOT NULL DEFAULT '0',
    stamina INT(10) UNSIGNED NOT NULL DEFAULT '0',
    intellect INT(10) UNSIGNED NOT NULL DEFAULT '0',
    spirit INT(10) UNSIGNED NOT NULL DEFAULT '0',
    health INT(10) UNSIGNED NOT NULL DEFAULT '0',
    mana INT(10) UNSIGNED NOT NULL DEFAULT '0',
    attack_power INT(10) UNSIGNED NOT NULL DEFAULT '0',
    spell_power INT(10) UNSIGNED NOT NULL DEFAULT '0',
    armor INT(10) UNSIGNED NOT NULL DEFAULT '0',
    ranged_attack_power INT(10) UNSIGNED NOT NULL DEFAULT '0',
    update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (guid)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;