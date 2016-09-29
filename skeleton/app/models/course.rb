class Course < ActiveRecord::Base
  has_many(
    :enrollments,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Enrollment
  )

  has_many(
    :enrolled_students,
    through: :enrollments,
    source: :user
  )

  # has_many(
  #   :prereqs,
  #   primary_key: :prereq_id,
  #   foreign_key: :id,
  #   class_name: :Course
  # )

  belongs_to(
    :prereq,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: :Course
  )

  belongs_to(
    :professor,
    primary_key: :id,
    foreign_key: :instructor_id,
    class_name: :User
  )
end
