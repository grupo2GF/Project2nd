package getGame;

import java.awt.List;
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
        // Wait a second...
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

//        System.out.format("CPU load: %.1f%% (SISTEMA OPERACIONAL)%n", processor.getSystemCpuLoad() * 100);

        StringBuilder procCpu = new StringBuilder("CPU load per processor:");
        double[] load = processor.getProcessorCpuLoadBetweenTicks();
        for (double avg : load) {
            procCpu.append(String.format(" %.1f%%", avg * 100));
            porcentagemCPU += (avg*100);
            contador++;
        }
        
        return (String.format("Uso do CPU: %.2f", porcentagemCPU/contador));
        
    }

    private static String printMemory(GlobalMemory memory) {
        //long porcentagemRam = (memory.getAvailable()*1024/ memory.getTotal())*100;
//        System.out.println("RAM Total: " + FormatUtil.formatBytes(memory.getTotal()));
//        System.out.println("RAM Disponível: " + FormatUtil.formatBytes(memory.getAvailable()));
        return String.format("<html>Total: %s <br> Disponível: %s </html>",
                FormatUtil.formatBytes(memory.getTotal()),
                FormatUtil.formatBytes(memory.getAvailable()));
        //System.out.println("Usado: " + porcentagemRam + "%");
    }

    private static void printDisks(HWDiskStore[] diskStores) {
        System.out.println("Disks:");
        for (HWDiskStore disk : diskStores) {
            boolean readwrite = disk.getReads() > 0 || disk.getWrites() > 0;
            System.out.format(" %s: (model: %s - S/N: %s) size: %s, reads: %s (%s), writes: %s (%s), xfer: %s ms%n",
                    disk.getName(), disk.getModel(), disk.getSerial(),
                    disk.getSize() > 0 ? FormatUtil.formatBytesDecimal(disk.getSize()) : "?",
                    readwrite ? disk.getReads() : "?", readwrite ? FormatUtil.formatBytes(disk.getReadBytes()) : "?",
                    readwrite ? disk.getWrites() : "?", readwrite ? FormatUtil.formatBytes(disk.getWriteBytes()) : "?",
                    readwrite ? disk.getTransferTime() : "?");
            HWPartition[] partitions = disk.getPartitions();
            if (partitions == null) {
                // TODO Remove when all OS's implemented
                continue;
            }
            for (HWPartition part : partitions) {
                System.out.format(" |-- %s: %s (%s) Maj:Min=%d:%d, size: %s%s%n", part.getIdentification(),
                        part.getName(), part.getType(), part.getMajor(), part.getMinor(),
                        FormatUtil.formatBytesDecimal(part.getSize()),
                        part.getMountPoint().isEmpty() ? "" : " @ " + part.getMountPoint());
            }
        }
    }

    public String getCPU() {
        SystemInfo si = new SystemInfo();
        HardwareAbstractionLayer hal = si.getHardware();
//        System.out.println("Nome: " + hal.getComputerSystem().getModel());
//        return si.getHardware().getProcessor().toString()+"\r\n"+printCpu(si.getHardware().getProcessor());
        return String.format("<html>%s <br> %s</html>",
                si.getHardware().getProcessor().toString(),
                printCpu(si.getHardware().getProcessor())+"%");
    }

    public String getRAM() {
        SystemInfo si = new SystemInfo();
        HardwareAbstractionLayer hal = si.getHardware();
//        System.out.println("Nome: " + hal.getComputerSystem().getModel());
        
        return printMemory(hal.getMemory());
    }

    public String getDisco() {
        SystemInfo si = new SystemInfo();
        HardwareAbstractionLayer hal = si.getHardware();
        System.out.println("Nome: " + hal.getComputerSystem().getModel());
        printDisks(hal.getDiskStores());
        return hal.getDiskStores().toString();
    }
    
}
