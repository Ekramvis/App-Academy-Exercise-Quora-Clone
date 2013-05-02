module Table

  def addition(table, options)
    question_marks = ("?," * options.keys.size).chop
      query = <<-SQL
   INSERT INTO #{table} (#{options.keys.join(",")})
        VALUES (#{question_marks})
      SQL

    query
  end

end