SELECT is_from_me, text, datetime(
    (date/1000000000) + strftime('%s', '2001-01-01 00:00:00'), 'unixepoch', 'localtime'
) AS date FROM message WHERE handle_id = (
    SELECT handle_id FROM chat_handle_join WHERE chat_id = (
        SELECT ROWID FROM chat WHERE guid='${line}'
    )
)
