using System.Collections.Generic;
using System.Linq;

public class GradeSchool
{
    private class Student
    {
        public Student(string name, int grade)
        {
            Name  = name;
            Grade = grade;
        }

        public string Name  { get; }
        public int    Grade { get; }
    }

    private IList<Student> _students;

    public GradeSchool()
        => _students = new List<Student>();

    public void Add(string student, int grade)
        => _students.Add(new Student(student, grade));

    public IEnumerable<string> Roster()
        => _students
            .OrderBy(s => s.Grade)
            .ThenBy(s => s.Name)
            .Select(s => s.Name);

    public IEnumerable<string> Grade(int grade)
        => _students
            .Where(s => s.Grade == grade)
            .OrderBy(s => s.Name)
            .Select(s => s.Name);
}