require_relative "questions_database"

class QuestionFollower

  def self.find_by_id(id)
    query = <<-SQL
      SELECT *
        FROM question_followers
       WHERE question_followers.id = ?
    SQL

    QuestionsDatabase.instance.execute(query, id)
  end


  def self.add_follower(user_id, question_id)
    query = <<-SQL
 INSERT INTO question_followers (user_id, question_id)
      VALUES (?, ?)
    SQL

    QuestionsDatabase.instance.execute(query, user_id, question_id)
  end

  def self.followers_for_question_id(id)
    query = <<-SQL
      SELECT u.fname, u.lname
        FROM question_followers as qf
        JOIN users as u
          ON u.id = qf.user_id
       WHERE qf.question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id)
  end

  def self.followed_questions_for_user_id(id)
    query = <<-SQL
      SELECT *
        FROM questions AS q
        JOIN question_followers as qf
          ON qf.question_id = q.id
       WHERE qf.user_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id)

    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    query = <<-SQL
      SELECT q.*
        FROM questions AS q
        JOIN question_followers AS qf
          ON q.id = qf.question_id
    GROUP BY q.id
    ORDER BY COUNT(qf.user_id) DESC
       LIMIT ?
    SQL

    QuestionsDatabase.instance.execute(query, n)
  end

end
