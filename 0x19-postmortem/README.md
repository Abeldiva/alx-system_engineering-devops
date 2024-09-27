This is a 0x19. Postmortem project.

Issue Summary

Duration: September 25, 2024, 08:00 AM to 11:00 AM UTC (3 hours)

Impact: The company’s primary web service was entirely unavailable during the outage. Approximately 90% of users were unable to access the website, while the remaining 10% experienced slow performance or incomplete page loads. API services were also affected, causing disruptions for integrated applications.

Root Cause: Misconfiguration in the Nginx server caused the system to hit the maximum number of open file descriptors, leading to the server being unable to handle incoming connections.

Timeline

08:00 AM: Issue detected through multiple user complaints reporting the website being down.
08:05 AM: The DevOps team received an alert from the monitoring system (Datadog) indicating a high number of 500 errors from the web server.
08:10 AM: Initial investigation started by checking server status and error logs on the web server (Nginx).
08:20 AM: The team suspected a database issue as the root cause due to slow query responses observed during initial investigation.
08:45 AM: Escalated to the database team to investigate any potential slowdowns or locks.
09:15 AM: Database ruled out as the issue persisted despite resolving queries.
09:30 AM: Focus shifted back to the web server (Nginx) where multiple “too many open files” errors were discovered in the logs.
09:45 AM: Identified the cause as Nginx hitting the limit on open file descriptors.
10:00 AM: Configurations on the Nginx server were updated to increase the limit for open file descriptors.
10:30 AM: Services were restarted and functionality was restored. Monitoring confirmed services were back online.
11:00 AM: Issue fully resolved, website performance returned to normal.

Root cause and resolution
The root cause of the outage was an Nginx server misconfiguration. The server’s file descriptor limit (ulimit -n) was set too low to handle the number of incoming connections and file system operations required to serve user requests. When the server reached the maximum number of open file descriptors, it could not handle any more connections, resulting in a 500 error for most users.

Resolution
The file descriptor limit was increased in the Nginx configuration by updating the worker_rlimit_nofile directive.
Additionally, the operating system’s limit for open file descriptors (/etc/security/limits.conf) was raised to ensure the new Nginx configuration would take effect.
After applying the configuration changes, the Nginx service was restarted, and normal operations were restored.

Corrective and preventative measures

Improve Monitoring:
1. Set up alerts to monitor the usage of file descriptors on all web servers.
2. Add monitoring on Nginx’s active connections and system resource limits to identify similar issues early.

Configuration Audits
1. Perform regular audits of server configurations (such as file descriptor limits) to ensure they are properly scaled for expected traffic.
2. Automate configuration checks to ensure production environments maintain optimal settings.

Increase Scalability
1. Increase the default file descriptor limit across all web servers.
2. Implement load balancing or traffic throttling during periods of high load to prevent server overload.

Test Environment Simulation
1. Simulate high traffic scenarios in the testing environment to better prepare the system for peak loads and validate configurations.


