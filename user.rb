require_relative 'questions_database'


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

  def authored_questions
    query = <<-SQL
      SELECT *
        FROM questions
       WHERE questions.author_id = ?
    SQL

    QuestionsDatabase.instance.execute(query, @id)
  end


  def authored_replies
    query = <<-SQL
      SELECT *
        FROM replies
       WHERE replies.author_id = ?
    SQL

    QuestionsDatabase.instance.execute(query, @id)
  end


end
