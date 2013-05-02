class Table

  def self.addition(table, *columns)
    question_marks = (columns.size * "?,").chop
      query = <<-SQL
   INSERT INTO #{table} (#{columns.join(",")})
        VALUES (#{question_marks})
      SQL

    query
  end

end