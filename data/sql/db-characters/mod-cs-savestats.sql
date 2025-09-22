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
    update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (guid)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

  -- 아래는 나중에 새로운 스탯(예: ranged_attack_power)을 추가할 때 사용할 수 있는 전문적인 패턴입니다.
  -- 이 예제는 ranged_attack_power 컬럼이 테이블에 없을 경우에만 추가합니다.

  DELIMITER $$
  CREATE PROCEDURE add_ranged_attack_power_if_not_exists()
  BEGIN
      IF NOT EXISTS (
          SELECT NULL
          FROM INFORMATION_SCHEMA.COLUMNS
          WHERE table_name = 'custom_character_stats'
            AND table_schema = DATABASE()
            AND column_name = 'ranged_attack_power'
      ) THEN
          ALTER TABLE custom_character_stats
          ADD COLUMN ranged_attack_power INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER attack_power;
      END IF;
  END $$
  DELIMITER ;

  -- 프로시저를 호출하여 컬럼을 추가합니다.
  CALL add_ranged_attack_power_if_not_exists();

  -- 더 이상 필요 없는 프로시저를 삭제합니다.
  DROP PROCEDURE add_ranged_attack_power_if_not_exists;