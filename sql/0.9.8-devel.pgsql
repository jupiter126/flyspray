-- Added on 07 March 05
INSERT INTO flyspray_prefs (pref_name, pref_value, pref_desc) VALUES ('global_theme', 'Bluey', 'Theme to use when viewing all projects');
INSERT INTO flyspray_prefs (pref_name, pref_value, pref_desc) VALUES ('visible_columns', 'id project category tasktype severity summary status progress', 'Columns visible when viewing all projects');

ALTER TABLE flyspray_list_tasktype ADD project_id NUMERIC(3);
UPDATE flyspray_list_tasktype SET project_id = 0;
ALTER TABLE flyspray_list_tasktype ALTER project_id SET NOT NULL;

ALTER TABLE flyspray_list_resolution ADD project_id NUMERIC(3);
UPDATE flyspray_list_resolution SET project_id = 0;
ALTER TABLE flyspray_list_resolution ALTER project_id SET NOT NULL;

ALTER TABLE flyspray_admin_requests ADD reason_given TEXT;
UPDATE flyspray_admin_requests SET reason_given = '';
ALTER TABLE flyspray_admin_requests ALTER reason_given SET NOT NULL;

-- added 20050320 by Jamin W. Collins - CHANGED on 29 March 05 
CREATE SEQUENCE "flyspray_notification_messages_message_id_seq" START WITH 2;
CREATE TABLE flyspray_notification_messages (
	message_id INT8  NOT NULL  DEFAULT nextval('"flyspray_notification_messages_message_id_seq"'::text),
	message_subject  TEXT   NOT NULL DEFAULT '',
	message_body   TEXT    NOT NULL DEFAULT '',
	time_created  TEXT,
	PRIMARY KEY (message_id)
);

CREATE SEQUENCE "flyspray_notification_recipients_recipient_id_seq" START WITH 2;
CREATE TABLE flyspray_notification_recipients (
	recipient_id INT8  NOT NULL  DEFAULT nextval('"flyspray_notification_recipients_recipient_id_seq"'::text),
	message_id  NUMERIC(10)  NOT NULL,
	notify_method      TEXT   NOT NULL DEFAULT '',
	notify_address      TEXT  NOT NULL DEFAULT '',
	PRIMARY KEY (recipient_id)
);

-- Added 27 March 05 
ALTER TABLE flyspray_projects ADD notify_email TEXT;
ALTER TABLE flyspray_projects ALTER notify_email SET DEFAULT '';
UPDATE flyspray_projects SET notify_email = '' WHERE notify_email IS NULL;
ALTER TABLE flyspray_projects ALTER notify_email SET NOT NULL;

ALTER TABLE flyspray_projects ADD notify_email_when NUMERIC(1);
ALTER TABLE flyspray_projects ALTER notify_email_when SET DEFAULT 0;
UPDATE flyspray_projects SET notify_email_when = 0 WHERE notify_email_when IS NULL;
ALTER TABLE flyspray_projects ALTER notify_email_when SET NOT NULL;

ALTER TABLE flyspray_projects ADD notify_jabber TEXT;
ALTER TABLE flyspray_projects ALTER notify_jabber SET DEFAULT '';
UPDATE flyspray_projects SET notify_jabber = '' WHERE notify_jabber IS NULL;
ALTER TABLE flyspray_projects ALTER notify_jabber SET NOT NULL;

ALTER TABLE flyspray_projects ADD notify_jabber_when NUMERIC(1);
ALTER TABLE flyspray_projects ALTER notify_jabber_when SET DEFAULT 0;
UPDATE flyspray_projects SET notify_jabber_when = 0 WHERE notify_jabber_when IS NULL;
ALTER TABLE flyspray_projects ALTER notify_jabber_when SET NOT NULL;

-- Added 3 April 05 
INSERT INTO flyspray_prefs (pref_name, pref_value, pref_desc) VALUES ('smtp_server', '', 'Remote mail server');
INSERT INTO flyspray_prefs (pref_name, pref_value, pref_desc) VALUES ('smtp_user', '', 'Username to access the remote mail server');
INSERT INTO flyspray_prefs (pref_name, pref_value, pref_desc) VALUES ('smtp_pass', '', 'Password to access the remote mail server');

-- Added 5 April 05 
ALTER TABLE flyspray_tasks ADD due_date TEXT;
ALTER TABLE flyspray_tasks ALTER due_date SET DEFAULT '';
UPDATE flyspray_tasks SET due_date = '' WHERE due_date IS NULL;
ALTER TABLE flyspray_tasks ALTER due_date SET NOT NULL;

-- Added 15 Apr 05 
ALTER TABLE flyspray_admin_requests ADD deny_reason TEXT;
ALTER TABLE flyspray_admin_requests ALTER deny_reason SET DEFAULT '';
UPDATE flyspray_admin_requests SET deny_reason = '' WHERE deny_reason IS NULL;
ALTER TABLE flyspray_admin_requests ALTER deny_reason SET NOT NULL;
