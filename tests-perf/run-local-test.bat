@echo off
REM Run JMeter tests locally and keep bugs visible

echo Starting Bug Tracker application...
cd /d "%~dp0\.."
docker compose up -d

echo Waiting for application to be ready...
npx wait-port http://localhost:8080/api/health -t 30000

echo Running JMeter bulk test (creates 100 bugs)...
cd tests-perf
jmeter -n -t bugtracker-bulk-test.jmx -l bulk-results.jtl -e -o bulk-report

echo.
echo Test completed!
echo.
echo View bugs at: http://localhost:3000
echo View JMeter report: tests-perf\bulk-report\index.html
echo.
echo To stop the application: docker compose down
pause
