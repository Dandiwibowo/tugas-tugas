-- Trigger for update created account when insert new data in tb_admin
DELIMITER $$
DROP TRIGGER IF EXISTS `setAdminCreatedDate`$$
CREATE TRIGGER setAdminCreatedDate 
BEFORE INSERT ON tb_admin FOR EACH ROW 
BEGIN
	 SET NEW.created_account = NOW();
END$$
DELIMITER ;

-- ----------------------------------------------------------

-- Trigger for update created account when insert new data in tb_software_programmer
DELIMITER $$
DROP TRIGGER IF EXISTS `setSPCreatedDate`$$
CREATE TRIGGER setSPCreatedDate 
BEFORE INSERT ON tb_software_programmer FOR EACH ROW 
BEGIN
	 SET NEW.created_account = NOW();
END$$
DELIMITER ;

-- ----------------------------------------------------------

-- Trigger for update created account when insert new data in tb_job_vacancy
DELIMITER $$
DROP TRIGGER IF EXISTS `setJVCreatedDate`$$
CREATE TRIGGER setJVCreatedDate 
BEFORE INSERT ON tb_job_vacancy FOR EACH ROW 
BEGIN
	 SET NEW.created_vacancy = NOW();
END$$
DELIMITER ;

-- ----------------------------------------------------------

-- Trigger for update created account when insert new data in tb_job_application
DELIMITER $$
DROP TRIGGER IF EXISTS `setJACreatedDate`$$
CREATE TRIGGER setJACreatedDate 
BEFORE INSERT ON tb_job_application FOR EACH ROW 
BEGIN
	 SET NEW.created_application = NOW();
END$$
DELIMITER ;

-- ----------------------------------------------------------

-- Trigger for update created account when insert new data in tb_thread
DELIMITER $$
DROP TRIGGER IF EXISTS `setThreadCreatedDate`$$
CREATE TRIGGER setThreadCreatedDate 
BEFORE INSERT ON tb_thread FOR EACH ROW 
BEGIN
	 SET NEW.created_thread = NOW();
END$$
DELIMITER ;

-- ----------------------------------------------------------

-- Trigger for update created account when insert new data in tb_thread_comment
DELIMITER $$
DROP TRIGGER IF EXISTS `setTCCreatedDate`$$
CREATE TRIGGER setTCCreatedDate 
BEFORE INSERT ON tb_thread_comment FOR EACH ROW 
BEGIN
	 SET NEW.created_comment = NOW();
END$$
DELIMITER ;

-- ----------------------------------------------------------

-- ////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////////////////////////


-- Trigger for update tb_job_vacancy_id when delete data in tb_job_vacancy
DELIMITER $$
DROP TRIGGER IF EXISTS `setJVDelete`$$
CREATE TRIGGER setJADelete 
BEFORE DELETE ON tb_job_vacancy FOR EACH ROW 
BEGIN
	 UPDATE tb_job_application SET tb_job_vacancy_id = '0' WHERE tb_job_vacancy_id = OLD.id;
END$$
DELIMITER ;
-- -----------------------------------------------------------------------------







-- Function for count thread by id user
-- Select id, countMyThread(id) From tb_software_programmer
DELIMITER $$

CREATE FUNCTION countMyThread(
   userId INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	return (Select count(id) FROM tb_thread WHERE tb_software_programmer_id = userId);
END $$

DELIMITER ;

-- ----------------------------------------------------------



-- Function for count chat by id room
-- Select id, countMychat(id) From tb_chatroom
DELIMITER $$

CREATE FUNCTION countMyChat(
   roomId INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	return (Select count(id) FROM tb_message WHERE tb_chatroom_id = roomId);
END $$

DELIMITER ;

-- ----------------------------------------------------------




-- Store Procedure for unsent message
-- call unsentMessage(id)

DELIMITER $$
DROP PROCEDURE IF EXISTS `unsentMessage`$$
CREATE PROCEDURE unsentMessage(
    IN  messageId INT
)
BEGIN
	UPDATE tb_message SET text='Message was deleted' WHERE id=messageId;
END$$

DELIMITER ;

-- ----------------------------------------------------------

-- Store Procedure for show message
-- call showMyMessage(id)

DELIMITER $$
DROP PROCEDURE IF EXISTS `showMyMessage`$$
CREATE PROCEDURE showMyMessage(
    IN  roomId INT
)
BEGIN
	SELECT * FROM tb_message WHERE tb_chatroom_id=roomId;
END$$

DELIMITER ;

-- ----------------------------------------------------------