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
    local new_task = {
        id = #tasklist + 1,
        content = content,
        status = status,
        due_date = due_date
    }
    table.insert(tasklist, new_task)
    save_tasks()
    print("new task added!")
end

local function edit_task(id, content, status, due_date)
    id = tonumber(id)
    if tasklist[id] then
        tasklist[id].content = content
        tasklist[id].status = status
        tasklist[id].due_date = due_date
        save_tasks()
        print("task edited!")
    else
        print("task not found.")
    end
end

local function delete_task(id)
    id = tonumber(id)
    if tasklist[id] then
        table.remove(tasklist, id)
        print("task deleted!")
    else
        print("task not found.")
    end
end

local function save_tasks()
    local file = io.open("tasks.lua", "w")
    file:write("return {\n")
    for _, task in ipairs(tasklist) do
        file:write(string.format("  { id = %d, content = %q, status = %q, due_date = %q },\n",
            task.id, task.content, task.status, task.due_date))
    end
    file:write("}\n")
    file:close()
end

local function load_tasks()
    local ok, loaded = pcall(dofile, "tasks.lua")
    if ok and type(loaded) == "table" then
        tasklist = loaded
    else
        tasklist = {}
    end
end


function todo.toDo()
    print("Welcome to CLI ToDo List")
    print("Type 'help' for a list of commands")
    load_tasks()
    print("your current tasks: \n")
    view_tasks()
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
                - save
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
        elseif input == "save" then
            save_tasks()
        elseif input == "exit" then
            print("goodbye!")
            break
        else
            print("unknown command!")
        end
    end
end

return todo