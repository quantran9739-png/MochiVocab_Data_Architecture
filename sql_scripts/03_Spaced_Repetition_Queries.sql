USE MochiVocab;
GO
SELECT 
    v.word, 
    v.vietnamese_meaning, 
    t.memory_level, 
    t.next_review_time
FROM User_Vocab_Tracking t
JOIN Vocabularies v ON t.vocab_id = v.vocab_id
WHERE t.user_id = 1 AND t.next_review_time <= GETDATE();
