require_relative 'questions_database'
# require_relative 'table'

class User



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

#  @@tablename = 'users'
  # CAN WE DO THIS???
  def self.add_user(fname,lname)
    query = self.addition(@@tablename, fname, lname)

    QuestionsDatabase.instance.execute(query, fname, lname)
  end

end
