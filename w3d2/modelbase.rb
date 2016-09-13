class ModelBase
  def self.find_by_id id
    object = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self::DATABASE}
      WHERE
        id = ?
    SQL

    return nil if object.empty?
    self.new(object.first)
  end

  def self.all
    data = QuestionsDB.instance.execute("SELECT * FROM #{self::DATABASE}")
    data.map { |datum| self.new(datum) }
  end

  def save
    if @id
      QuestionsDB.instance.execute(<<-SQL)
        UPDATE
          users
        SET
          #{self.instance_variables[1..-1].map { |x| x.to_s[1..-1] + " = #{x}" }.join(", ")}
        WHERE
          @id = #{self.id}
      SQL
    else
      args = self.instance_variables[1..-1].map  do |x|
        self.method(x.to_s[1..-1].to_sym).call
      end

      QuestionsDB.instance.execute(<<-SQL, args)
        INSERT INTO
          users (#{self.instance_variables[1..-1].map { |x| x.to_s[1..-1] }.join(", ")})
        VALUES
          (#{self.instance_variables[1..-1].map{'?'}.join(", ")})
      SQL

      @id = QuestionsDB.instance.last_insert_row_id
    end

    self
  end

  def self.where options
    if options.is_a?(Hash)
      values = QuestionsDB.instance.execute(<<-SQL, options.values)
        SELECT
          *
        FROM
          #{self::DATABASE}
        WHERE
          #{options.keys.map{|x| x.to_s + '= ?'}.join(" AND ")}
      SQL
    else
      values = QuestionsDB.instance.execute(<<-SQL)
        SELECT
          *
        FROM
          #{self::DATABASE}
        WHERE
          #{options}
      SQL
    end

    values.map{|datum| self.new(datum)}
  end

  def self.method_missing(method_name, *args)
    method_name = method_name.to_s
    if method_name.start_with?("find_by_")
      attributes_string = method_name[("find_by_".length)..-1]
      attribute_names = attributes_string.split("_and_")

      unless attribute_names.length == args.length
        raise "unexpected # of arguments"
      end

      search_conditions = {}
      attribute_names.each_index do |i|
        search_conditions[attribute_names[i]] = args[i]
      end

      self.where(search_conditions)
    end
  end
end
