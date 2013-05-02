require_relative 'questions_database'

class User < Table

  def self.find_by_id(id)
    query = <<-SQL
      SELECT *
        FROM users
       WHERE users.id = ?
    SQL

    QuestionsDatabase.instance.execute(query, id)
  end

  def self.add_user(fname,lname)
    query = <<-SQL
 INSERT INTO users (fname, lname)
      VALUES (?, ?)
    SQL

    QuestionsDatabase.instance.execute(query, fname, lname)
  end

end
