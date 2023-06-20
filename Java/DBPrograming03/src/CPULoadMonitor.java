import java.lang.management.ManagementFactory;
import com.sun.management.OperatingSystemMXBean;


public class CPULoadMonitor {

    final OperatingSystemMXBean osBean =
            (com.sun.management.OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();

    double load;

    CPULoadMonitor() {
        while (true) {
            load = osBean.getSystemCpuLoad();

            if (load < 0.0)
                continue;

            System.out.println("CPU Usage : " + load * 100.0 + "%");
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
