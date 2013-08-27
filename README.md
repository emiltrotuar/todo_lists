Task manager http://mysterious-bastion-4641.herokuapp.com/

Setup

1. cd todo_lists (use rvm)
2. install gems via bundle
3. run rake db:migrate


SQL task

Given tables:
	● tasks (id, name, status, project_id)
	● projects (id, name)


1. get all statuses, not repeating, alphabetically ordered

	SELECT DISTINCT status 
	FROM tasks 
	ORDER BY status ASC

2. get the count of all tasks in each project, order by tasks count descending

	SELECT COUNT(*) tcount 
	FROM tasks 
	GROUP BY project_id 
	ORDER BY tcount DESC

3. get the count of all tasks in each project, order by projects names

	SELECT COUNT(*), projects.name 
	FROM tasks INNER JOIN projects 
	ON project_id = projects.id 
	GROUP BY projects.name 
	ORDER BY projects.name

4. get the tasks for all projects having the name beginning with “N” letter

	SELECT * 
	FROM tasks 
	WHERE name like 'N%'

5. get the list of all projects containing the ‘a’ letter in the middle of the name, and show the tasks count near each project. Mention that there can exist projects without tasks and tasks with project_id=NULL

	SELECT projects.name
	FROM projects RIGHT JOIN tasks 
	ON projects.id = tasks.project_id 
	WHERE projects.name LIKE '%a%' 
	GROUP BY projects.name

6. get the list of tasks with duplicate names. Order alphabetically

	SELECT name, id 
	FROM tasks INNER JOIN (SELECT id, name FROM tasks 
												 GROUP BY name 
												 HAVING COUNT(id) > 1) duplicated  
	ON tasks.name = duplicated.name 
	ORDER BY tasks.name

7. get the list of tasks having several exact matches of both name and status, from the project ‘Garage’. Order by matches count

	SELECT name, id, status 
	FROM tasks INNER JOIN (SELECT id, status, name 
												 FROM tasks 
												 GROUP BY status 
												 HAVING count(id) > 1) duplicated 
	ON tasks.status = duplicated.status 
	WHERE project_id IN (SELECT id FROM projects 
											 WHERE name = 'GARAGE')
	ORDER BY name

8. get the list of project names having more than 10 tasks in status ‘completed’. Order by project_id

	SELECT projects.name, COUNT(tasks.id) tcount 
	FROM projects RIGHT JOIN tasks 
	ON projects.id = tasks.project_id 
	WHERE tasks.status = 'completed' 
	GROUP BY projects.name 
	HAVING tcount > 10 
	ORDER BY projects.id

