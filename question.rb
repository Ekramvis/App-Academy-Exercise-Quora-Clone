require_relative 'questions_database'
# require_relative 'table'

class Question

  def self.find_by_id(id)
    query = <<-SQL
      SELECT *
        FROM questions
       WHERE questions.id = ?
    SQL

    QuestionsDatabase.instance.execute(query, id)
  end

  def self.add_question(title, body, author_id)
    query = <<-SQL
 INSERT INTO questions (title, body, author_id)
      VALUES (?, ?, ?)
    SQL

    QuestionsDatabase.instance.execute(query, title, body, author_id)
  end

end
