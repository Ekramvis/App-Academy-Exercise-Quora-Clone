require_relative "questions_database"

class QuestionLike

  def initialize()

  def self.find_by_id(id)
    query = <<-SQL
      SELECT *
        FROM question_likes
       WHERE question_likes.id = ?
    SQL

    QuestionsDatabase.instance.execute(query, id)
  end


  def self.add_like(user_id, question_id)
    query = <<-SQL
 INSERT INTO question_likes (user_id, question_id)
      VALUES (?, ?)
    SQL

    QuestionsDatabase.instance.execute(query, user_id, question_id)
  end

  def self.likers_for_question_id(question_id)
    query = <<-SQL
      SELECT u.*
        FROM question_likes AS ql
        JOIN users AS u
          ON u.id = ql.user_id
       WHERE ql.question_id = ?
    SQL

    QuestionsDatabase.instance.execute(query, question_id)
  end

end
