JobsCoreConfig = {}
JobsCoreConfig.Jobs = {}
JobsCoreConfig.Requirements = {}
JobsCoreConfig.StaticJobLabels = {}
---------------------------------------------------------------------------
JobsCoreConfig.Jobs = {"UNEMPLOYED", "POLICE", "STATE", "SHERIFF"} -- Always Update This When You Are Adding New Jobs AND THIS IS ALL THE JOBS EVEN IF THEY ARE NOT INSTALLED ON YOUR SERVER
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- Static Jobs
---------------------------------------------------------------------------
JobsCoreConfig.StaticJobLabels = { ["UNEMPLOYED"] = "Unemployed", ["POLICE"] = "Police", ["STATE"] = "State", ["SHERIFF"] = "Sheriff" }
---------------------------------------------------------------------------
JobsCoreConfig.AllowSalary = true -- If you want players to get a salary from being unemployed
JobsCoreConfig.SalaryRecieveTimer = 600000 -- This Timer Is Used To Give You The Salary, currently set at 10 mins. 600000ms = 10 mins
JobsCoreConfig.SalaryAmount = 25
