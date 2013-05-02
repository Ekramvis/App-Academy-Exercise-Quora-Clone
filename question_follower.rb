require "questions_database"

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

end
