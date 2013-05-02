require_relative 'questions_database'
# require_relative 'table'

class Question

  def initialize(attributes = {})
    @id = attributes["id"]
    @title = attributes["title"]
    @body = attributes["body"]
    @author_id = attributes["author_id"]
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end


  def self.find_by_author_id(id)
    query = <<-SQL
      SELECT *
        FROM questions
       WHERE questions.author_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id)
    results.map { |result| Question.new(result) }
  end

  def self.find_by_id(id)
    query = <<-SQL
      SELECT *
        FROM questions
       WHERE questions.id = ?
    SQL

    QuestionsDatabase.instance.execute(query, id)
  end


end
