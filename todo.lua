local todo = {}

local task = {
    id = 1, 
    content = "Create List",
    status = "pending",
    due_date = os.date("%Y-%m-%d")
}

local tasklist = {task}

local function view_tasks()
    for _, task in pairs(tasklist) do
        print("ID: " .. task.id .. " | " .. task.content .. " | " .. task.status .. " | Due: " .. task.due_date)
    end
end

local function add_task(content, status, due_date)
    new_task = {
        id = #tasklist + 1,
        content = content,
        status = status,
        due_date = due_date
    }
    tasklist[#tasklist + 1] = new_task
    print("new task added!")
end

local function edit_task(id, content, status, due_date)
    _task = {
        id = #tasklist + 1,
        content = content,
        status = status,
        due_date = due_date
    }
    tasklist[id] = _task
    print("task edited!")
end

local function delete_task(id)
    table.remove(tasklist, id)
end

function todo.toDo()
    print("Welcome to CLI ToDo List")
    print("Type 'help' for a list of commands")
    local list = {}
    while true do
        io.write("> ")
        local input = io.read()
        if input == "help" then 
            print([[
                Available commands:
                - help
                - exit
                - list
                - new
                - edit
                - delete
            ]])
        elseif input == "list" then
            view_tasks()
        elseif input == "new" then
            print("task name: \n")
            local content = io.read()
            print("task status (not started, in-progress, complete):")
            local status = io.read()
            print("due date:")
            local due_date = io.read()
            add_task(content, status, due_date)
        elseif input == "edit" then
            print("task id: \n")
            local id = io.read()
            print("task name: \n")
            local content = io.read()
            print("task status (not started, in-progress, complete):")
            local status = io.read()
            print("due date:")
            local due_date = io.read()
            edit_task(id, content, status, due_date)
        elseif input == "delete" then 
            print("task id: \n")
            local id = io.read()
            delete_task(id)
        elseif input == "exit" then
            print("goodbye!")
            break
        else
            print("unknown command!")
        end
    end
end

return todo