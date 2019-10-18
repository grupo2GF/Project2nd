
import oshi.SystemInfo;
import oshi.hardware.GlobalMemory;
import oshi.hardware.HardwareAbstractionLayer;
import oshi.software.os.OSProcess;
import oshi.software.os.OperatingSystem;
import oshi.util.FormatUtil;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class TesteProcessos {

    private static List<String> oshi = new ArrayList<String>();

    public void getProcessos() {
        SystemInfo si = new SystemInfo();
        HardwareAbstractionLayer hal = si.getHardware();
        OperatingSystem os = si.getOperatingSystem();
        printProcesses(os, hal.getMemory());

        System.out.println(oshi);
    }

    private static void printProcesses(OperatingSystem os, GlobalMemory memory) {
        oshi.add("Processes: " + os.getProcessCount() + ", Threads: " + os.getThreadCount());
        // Sort by highest CPU
        List<OSProcess> procs = Arrays.asList(os.getProcesses(10, OperatingSystem.ProcessSort.MEMORY));

        oshi.add("\r\n     PID  %CPU %MEM       RSS Name\r\n");
        for (int i = 0; i < procs.size() && i < Integer.MAX_VALUE; i++) {
            OSProcess p = procs.get(i);
            oshi.add(String.format(" %5d %5.1f %4.1f %9s %s%n", p.getProcessID(),
                    100d * (p.getKernelTime() + p.getUserTime()) / p.getUpTime(),
                    100d * p.getResidentSetSize() / memory.getTotal(),
                    FormatUtil.formatBytes(p.getResidentSetSize()), p.getName()));
        }
    }
}
