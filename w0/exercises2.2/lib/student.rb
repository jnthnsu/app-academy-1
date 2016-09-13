class Student
	attr_accessor :first_name, :last_name, :courses
	def initialize first_name, last_name, courses = []
		@first_name = first_name
		@last_name = last_name
		@courses = courses
	end

	def name
		"#{@first_name} #{@last_name}"
	end

	def enroll course
		raise if @courses.any?{|c| course.conflicts_with?(c)}
		unless @courses.include?(course)
			@courses.push(course)
			course.students.push(self)
		end
	end

	def course_load
		@courses.inject(Hash.new(0)) do |course_load, course|
			course_load[course.department] += course.credits
			course_load
		end
	end
end
