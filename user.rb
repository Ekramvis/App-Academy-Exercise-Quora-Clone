require_relative 'questions_database'
require_relative 'question'


class User

  attr_accessor :fname, :lname, :id

  def initialize(attributes = {})
    @id = attributes["id"]
    @fname = attributes["fname"]
    @lname = attributes["lname"]
  end

  def self.find_by_name(fname, lname)
    query = <<-SQL
      SELECT *
        FROM users
       WHERE users.fname = ? AND users.lname = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, fname, lname)

    results.map {|result| User.new(result)}[0]
  end

  def self.find_by_id(id)
    query = <<-SQL
      SELECT *
        FROM users
       WHERE users.id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id)

    results.map {|result| User.new(result)}[0]
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end


  def authored_replies
    Reply.find_by_user_id(@id)
  end


end
