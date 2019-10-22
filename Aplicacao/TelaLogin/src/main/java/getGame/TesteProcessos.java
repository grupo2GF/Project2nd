package getGame;

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
    private String stringFinal;
    
    public String getProcessos() {
        stringFinal = "";
        SystemInfo si = new SystemInfo();
        HardwareAbstractionLayer hal = si.getHardware();
        OperatingSystem os = si.getOperatingSystem();
        printProcesses(os, hal.getMemory());

        
        
        for (String parteTexto : oshi) {;
            stringFinal=parteTexto.concat(oshi + "<br>");
        }
        System.out.println(stringFinal);

        return stringFinal;
    }

    private static void printProcesses(OperatingSystem os, GlobalMemory memory) {
        oshi.removeAll(oshi);
        // Sort by highest CPU
        List<OSProcess> procs = Arrays.asList(os.getProcesses(1, OperatingSystem.ProcessSort.MEMORY));

        for (int i = 0; i < procs.size() && i < Integer.MAX_VALUE; i++) {
            OSProcess p = procs.get(i);
            oshi.add(String.format(" %5d %5.1f %4.1f %s%n", 
                    p.getProcessID(),
                    100d * (p.getKernelTime() + p.getUserTime()) / p.getUpTime(),
                    100d * p.getResidentSetSize() / memory.getTotal(), 
                    p.getName()));
        }
    }
}
