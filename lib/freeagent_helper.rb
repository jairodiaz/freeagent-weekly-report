require 'freeagent'

def user(url)
  user_id = FreeAgent::User.new('url' => url).id
  FreeAgent::User.find(user_id)
end

def project(url)
  project_id = FreeAgent::Project.new('url' => url).id
  FreeAgent::Project.find(project_id)
end

def task(url)
  task_id = FreeAgent::Task.new('url' => url).id
  FreeAgent::Task.find(task_id)
end
