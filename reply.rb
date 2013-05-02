require_relative 'questions_database'
# require_relative 'table'

class Reply

  def child_replies
    query = <<-SQL
      SELECT body
        FROM replies
       WHERE replies.parent_id = #{@id}
    SQL
    QuestionsDatabase.instance.execute(query)
  end

  def parent_reply
    if @parent_id
      Reply.find_by_id(@parent_id)
    else
      raise Exception.new "no parent"
    end
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def self.find_by_question_id(id)
    query = <<-SQL
      SELECT *
        FROM replies
       WHERE replies.question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id)
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_user_id(id)
    query = <<-SQL
      SELECT *
        FROM replies
       WHERE replies.author_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id)
    results.map { |result| Reply.new(result) }
  end

  def initialize(attributes={})
    @id = attributes["id"]
    @question_id = attributes["question_id"]
    @parent_id = attributes["parent_id"]
    @author_id = attributes["author_id"]
    @body = attributes["body"]
  end


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
