require_relative 'questions_database'
# require_relative 'table'

class Reply

  def self.find_by_id(id)
    query = <<-SQL
      SELECT *
        FROM replies
       WHERE replies.id = ?
    SQL

    QuestionsDatabase.instance.execute(query, id)
  end

  def self.add_reply(question_id, parent_id, author_id, body)
    query = <<-SQL
 INSERT INTO replies (question_id, parent_id, author_id, body)
      VALUES (?, ?, ?, ?)
    SQL

    QuestionsDatabase.instance.execute(query, question_id, parent_id, author_id, body)
  end

end
