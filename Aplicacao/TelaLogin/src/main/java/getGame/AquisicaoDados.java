package getGame;

import java.awt.List;
import java.io.File;
import java.util.Arrays;
import oshi.SystemInfo;
import oshi.hardware.*;
import oshi.software.os.OperatingSystem;
import oshi.hardware.CentralProcessor;
import oshi.hardware.CentralProcessor.TickType;
import oshi.software.os.OSProcess;
import oshi.software.os.OperatingSystem.ProcessSort;
import oshi.util.FormatUtil;
import oshi.util.Util;

public class AquisicaoDados {
    
    private static String printCpu(CentralProcessor processor) {

        long[] prevTicks = processor.getSystemCpuLoadTicks();
        
        
        Util.sleep(1000);
        Double porcentagemCPU = 0.0;
        int contador = 0;
        long[] ticks = processor.getSystemCpuLoadTicks();

        long user = ticks[TickType.USER.getIndex()] - prevTicks[TickType.USER.getIndex()];
        long nice = ticks[TickType.NICE.getIndex()] - prevTicks[TickType.NICE.getIndex()];
        long sys = ticks[TickType.SYSTEM.getIndex()] - prevTicks[TickType.SYSTEM.getIndex()];
        long idle = ticks[TickType.IDLE.getIndex()] - prevTicks[TickType.IDLE.getIndex()];
        long iowait = ticks[TickType.IOWAIT.getIndex()] - prevTicks[TickType.IOWAIT.getIndex()];
        long irq = ticks[TickType.IRQ.getIndex()] - prevTicks[TickType.IRQ.getIndex()];
        long softirq = ticks[TickType.SOFTIRQ.getIndex()] - prevTicks[TickType.SOFTIRQ.getIndex()];
        long steal = ticks[TickType.STEAL.getIndex()] - prevTicks[TickType.STEAL.getIndex()];
        long totalCpu = user + nice + sys + idle + iowait + irq + softirq + steal;

        StringBuilder procCpu = new StringBuilder("CPU load per processor:");
        double[] load = processor.getProcessorCpuLoadBetweenTicks();
        for (double avg : load) {
            procCpu.append(String.format(" %.1f%%", avg * 100));
            porcentagemCPU += (avg * 100);
            contador++;
        }

        return (String.format("Uso do CPU: %.2f", porcentagemCPU / contador));

    }

    private static String printMemory(GlobalMemory memory) {

        return String.format("<html>Total: %s <br> Disponível: %s </html>",
                FormatUtil.formatBytes(memory.getTotal()),
                FormatUtil.formatBytes(memory.getAvailable()));
    }

    private static String printDisks(HWDiskStore[] diskStores) {

        String dadosDisco = null;
        File[] roots = File.listRoots();
        for (File root : roots) {
            String usedSpace = FormatUtil.formatBytes(root.getTotalSpace() - root.getUsableSpace());
            String discos = String.format("%s: %s used of %s%n",
                    root.getAbsolutePath(), usedSpace, FormatUtil.formatBytes(root.getTotalSpace()));
            dadosDisco = discos;
        }
        
        
        return dadosDisco;
        
    }

    public String getCPU() {
        SystemInfo si = new SystemInfo();
        HardwareAbstractionLayer hal = si.getHardware();

        return String.format("<html>%s <br> %s</html>",
                si.getHardware().getProcessor().toString(),
                printCpu(si.getHardware().getProcessor()) + "%");
    }

    public String getRAM() {
        SystemInfo si = new SystemInfo();
        HardwareAbstractionLayer hal = si.getHardware();

        return printMemory(hal.getMemory());
    }

    public String getDisco() {
        SystemInfo si = new SystemInfo();
        HardwareAbstractionLayer hal = si.getHardware();

        printDisks(hal.getDiskStores());
        return String.format("%s",printDisks(hal.getDiskStores()));
    }

}
