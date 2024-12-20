CREATE DATABASE firmaxy;
USE firmaxy;

CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    position VARCHAR(50),
    department_id INT,
    start_date DATE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Call_Center_Agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL UNIQUE,
    agent_code VARCHAR(20) NOT NULL UNIQUE,
    assigned_department_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (assigned_department_id) REFERENCES Departments(department_id)
);


CREATE TABLE Department_Heads (
    department_id INT,
    head_employee_id INT,
    PRIMARY KEY (department_id, head_employee_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (head_employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Employee_Managers (
    employee_id INT,
    manager_id INT,
    PRIMARY KEY (employee_id, manager_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    industry VARCHAR(50)
);

CREATE TABLE Agent_Client_Interactions (
    interaction_id INT AUTO_INCREMENT PRIMARY KEY,
    agent_id INT NOT NULL,
    client_id INT NOT NULL,
    interaction_date DATETIME,
    notes TEXT,
    FOREIGN KEY (agent_id) REFERENCES Call_Center_Agents(agent_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);


CREATE TABLE Client_Contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    contact_person VARCHAR(100),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

CREATE TABLE Projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    client_id INT,
    start_date DATE,
    end_date DATE,
    department_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
	department_id INT,
    assigned_to INT,
    project_id INT,
    due_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (assigned_to) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    city VARCHAR(50),
    country VARCHAR(50),
    phone VARCHAR(20)
);

CREATE TABLE Service_Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    category_id INT,
    price_model VARCHAR(50),
    FOREIGN KEY (category_id) REFERENCES Service_Categories(category_id)
);

CREATE TABLE Service_Packages (
    package_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2),
    validity_period VARCHAR(50)
);

CREATE TABLE Service_Assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT,
    project_id INT,
    assigned_date DATE,
    assigned_to INT,
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (assigned_to) REFERENCES Employees(employee_id)
);

CREATE TABLE Service_Project_Relationships (
    service_id INT,
    project_id INT,
    PRIMARY KEY (service_id, project_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE Interaction_Types (
    interaction_type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE Customer_Interactions (
    interaction_id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT,
    client_id INT,
    interaction_type_id INT,
    date DATETIME,
    duration_minutes INT,
    feedback_score INT,
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (client_id) REFERENCES Agent_Client_Interactions(client_id),
	FOREIGN KEY (interaction_type_id) REFERENCES Interaction_Types(interaction_type_id)
);

CREATE TABLE Service_Usage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT,
    client_id INT,
    project_id INT,
    start_date DATE,
    end_date DATE,
    total_hours DECIMAL(10,2),
    total_cost DECIMAL(10,2),
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE Metric_Types (
    metric_type_id INT AUTO_INCREMENT PRIMARY KEY,
    metric_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Performance_Metrics (
    metric_id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT,
    metric_type_id INT,
    value DECIMAL(10,2),
    recorded_date DATE,
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (metric_type_id) REFERENCES Metric_Types(metric_type_id)
);
