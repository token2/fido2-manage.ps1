function Test-Administrator  
{  
    [OutputType([bool])]
    param()
    process {
        [Security.Principal.WindowsPrincipal]$user = [Security.Principal.WindowsIdentity]::GetCurrent();
        return $user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
    }
}

if(-not (Test-Administrator))
{
    # TODO: define proper exit codes for the given errors 
    Write-Error "This script must be executed as Administrator.";
    exit 1;
}


$Icon = "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2/8gGNT/KyHW/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8kG9X/LCbW/8rH9f+5tvH/IBvS/x8W1P8gF9T/IBfU/yAX1P8gFtT/IRjU/ygf1v8rItb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8lHNX/Jx7V/7y68v/JxvT/Jh3V/yce1v8qINb/KSDW/ykg1v8pINb/KSDW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8nHtX/IBbU/6ik7v/p5/v/OTHZ/yMZ1P8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8pINb/HRTT/3x35v/w7/z/X1ng/xkR0v8rItb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8rItb/HxfU/0A62v/d2/n/q6nv/x4W0/8nHtX/KyLW/yoh1v8hF9T/IBfU/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8qIdb/KR/W/x0U1P+fm+3/6Of7/11W4P8eFdT/KSDW/yUc1f9qZOL/WVPf/x4V1P8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/x8W1P8/ONr/4N/5/5SP6v8gFtT/JBrV/yUc1f+zr/D/2df4/0M72/8gF9T/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8iGtX/XFXg/0E52v8lHNX/KiHW/yMa1f9GQdv/3975/56a7P8fFtT/Jx7V/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/IBfU/yQb1f8rItb/KiHW/yoh1v8UEdL/m5js/8rH9f8sJtb/JBvV/yoh1v8qIdb/KiHW/yoh1v8qIdb1KiHW9Soh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7f///////////////////////////////////////////////////////////6Ke7f8AAM3/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdbxKiHW8Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8EAM//oJzt///////n5/r/qqbv/7az8f+2s/H/trPx/7az8f+2s/H/trPx/7az8f+2s/H/a2Tj/xEL0f8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1vEqIdbxKiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/wYAz/+Xkuv//////6Sg7v8AAMn/CwDQ/woA0P8KAND/CgDQ/woA0P8KAND/CgDQ/woA0P8bEtP/MCbX/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW8Soh1vEqIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/CADP/4aC6P//////uLTx/w4E0P8oH9b/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdbxKiHW8Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8LAND/bGbj///////S0Pb/GxHT/yQb1f8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1vEqIdbxKiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/xMJ0f9LQ9z///////r5/v8xKdf/HBLT/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW8Soh1vEqIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/IRjU/yMZ1f/p6Pv//////19Y4P8JAM//KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdbxKiHW8Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/BQDP/6Gc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1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW3yoh1rAqIdZfKiHWICoh1gAqIdYcKiHWWyoh1q4qIdbXKiHW7yoh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW7yoh1tcqIdauKiHWWyoh1hsqIdZcKiHWqyoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHWqyoh1lwqIda8KiHW3Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW3Soh1r0qIdbqKiHW9Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW9Soh1uwqIdb3KiHW+yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/KSDW/yce1f8lHNX/JRzV/yUc1f8lHNX/JRzV/yUc1f8lHNX/JRzV/yUc1f8lHNX/JRzV/yUc1f8lHNX/JRzV/yUc1f8lHNX/Jh3V/ygf1v8qIdb/KyHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+yoh1vcqIdb0KiHW+Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ysi1v8uJNf/Jx3V/xwS0/8VC9L/EwnS/xMJ0v8TCdL/EwnS/xMJ0v8TCdL/EwnS/xMJ0v8TCdL/EwnS/xMJ0v8TCdL/EwnS/xMJ0v8TCdL/GQ/T/yIY1f8sItb/LSPX/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Soh1vQqIdbyKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/ysi1v8rItb/KyLW/ysi1v8rItb/KiHW/yog1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vIqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ygf1v8fF9T/Ni/Y/1hR3v9tZ+P/c23k/3Js5P9zbeT/c23k/3Nt5P9zbeT/c23k/3Nt5P9zbeT/c23k/3Nt5P9zbeT/c23k/3Nt5P9zbeT/Ylzh/0Y/3P8lHdX/IhrU/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yMb1f8NCNH/Skbc/6Kf7f/X1ff/5uX6/+Pi+v/j4vr/5OL6/+Pi+v/j4vr/4+L6/+Pi+v/j4vr/4+L6/+Pi+v/j4vr/4+L6/+Tj+v/k4/r/v7zz/3l15f8cGtP/Ew7R/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yIa1f8IBND/UE3d/7az8f/x8fz///////f3/f/l4/r/4uH6/+bl+v/m5fr/5uX6/+bl+v/m5fr/5uX6/+bl+v/m5fr/5uX6/+fm+v/n5vr/vrvz/3Vx5f8cGdP/Ew7R/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yMa1f8KBdD/TUnd/7Ct8P/w8Pz/8/P9/87N9f+al+v/kIzp/5mU6/+ZlOv/mJTr/5iU6/+YlOv/mJTr/5iU6/+YlOv/mJTr/5mV6/+Zlev/fXfm/1FJ3v8iG9T/HhbU/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yMa1f8LBdD/SkXc/6un7//v7/z/4N75/5aT6v80M9X/HBfR/ycd1f8mHdX/Jh3V/yYd1f8mHdX/Jh3V/yYd1f8mHdX/Jh3V/yYd1f8mHdX/Jx7V/ygg1v8qIdb/KyHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yMa1f8MBdD/RkDb/6Og7f/u7fz/3935/46K6f8cG9H/BADN/xQK0v8UCtL/FArS/xQK0v8UCtL/FArS/xQK0v8UCtL/FArS/xQK0v8UCtL/GRDT/yIZ1P8sItb/LSPW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yMb1f8NBdD/QDna/5iV6//r6/v/6Ob6/5+a7P8sI9b/FgzS/ygf1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yQb1f8PBdH/Ny/Z/4mF6f/o5/v/8fH8/6+r7/83Ltj/GA/T/yYd1f8pINb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yUc1f8TCNH/LybX/3hy5f/k4/r//////8bD9P9FPdv/HBLT/yIZ1P8oH9b/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yYd1f8YD9L/JhzV/2Nc4f/d3Pn//////9vZ+P9ZUt//IRjU/xwS0/8nHtX/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ygf1v8gF9T/HRPT/0pC3P/MyvX//////+Pi+v90buT/KyLW/xEI0f8lHNX/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ykg1v8nHtX/Fg3S/zAp1/+ope//7uz8/+zr+/+bl+z/Pzva/woFz/8kHNX/LCPW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/EwzS/x0X1P96deX/0M32//b1/f/Kx/X/YV3h/w8K0P8hGNT/KSDW/yoh1v8qIdb/KiHW/yoh1v8qItb/Jx7V/yQa1P8kG9X/Jx7W/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/GhHT/xkR0/9LRNz/r6zv///////29v3/kY7q/yoi1v8YDtL/HxbU/ywj1v8qIdb/KiHW/ysi1v8qIdb/IBbU/xYM0v8VC9L/IBbU/yoh1v8rItb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/IxrV/x0T1P8jG9X/hIDn/+vq+//9/f//wb7z/2dg4v8gF9T/GA/T/yoh1v8qIdb/KiHW/ygf1v8jGdX/PTTa/1RN3v9IQdz/LCTW/xoR0/8oH9b/LCPW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yMZ1f8OBNH/VlDf/7q48v/y8v3/7Ov7/6qn7/86M9n/GhHT/yMa1f8pINb/KB7W/yQa1f8hGNT/a2Xi/6+t8P+emuz/VE7e/xYN0v8hGNT/KR/W/ysi1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/LCPW/yYd1f8RCNL/KyPX/3Ru5P/j4vr//////9jX+P9lXuL/Jx7W/xgP0v8mHdX/IhnV/x0U1P8vJtf/lI/q//Ly/f/u7vz/mpbs/zw02f8XDtL/HBPU/ywj1/8rItb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/ykg1v8fFtT/Fw7T/z432v+4tfL/5eP6/8C98/9VTd7/JBvV/x0U0/8nHtX/JBvV/x8W1P8nHtb/eHLl/9TS9//49/7/19X3/4mD6P8oH9b/Fw3T/ygf1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/Fw/T/yIa1f94cuX/l5Lr/3135v8xKNf/HhXT/yce1f8pINb/KSDW/yQb1f8dE9T/Pzfa/4SA5//f3vn///7//8/M9v9NRd3/HRPU/x4V1P8oHtb/KiLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/JRzV/yQb1f8xKNj/NCvY/y4l1/8kG9X/Jh3V/ysi1v8qIdb/KyLW/ykg1v8iGdX/FA/S/zQz2P+vrvD/8vH9/+Ti+v98dub/MSjX/xII0f8lG9X/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/ygf1f8eFdT/GhHT/x0T0/8lHNX/KiHW/ysi1v8qIdb/KyLW/ysi1v8oH9b/DgrR/xkY0v9+e+b/1dP3/+3s+/+emuz/Qjzb/wsF0P8jGtX/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/ysi1v8mHdX/JRzV/yce1f8rItb/KyLW/yoh1v8qIdb/KiHW/ysi1v8sI9b/FA7S/xQQ0v9aVOD/vbry//Hw/P+yrvD/TUnd/wkF0P8iGtX/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8pINb/KSDW/ykh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/Fg7S/xYP0/9UTt7/uLbx//Lx/f+1svH/T0ze/wkF0P8iGtX/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/ysi1v8oH9b/JRzV/yUc1f8rItb/KyLW/yoh1v8qIdb/KiHW/ysi1v8tI9b/FA7R/xUT0v9mYeL/xcL0//Dv/P+rp+//SUXc/woF0P8jGtX/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/KiHW/ygf1f8iGdX/IBbU/yEX1P8lHNX/KB/V/yoh1v8qIdb/KiHW/ykg1v8lHdX/EAzQ/yIg1P+Oi+n/3935/+rp+/+Ri+n/OzTZ/w4G0P8kG9X/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ysi1v8tJNf/Jh3V/x4V0/8eFNP/JBvV/yUc1f8WDNL/GxLT/ygf1f8rItb/KyHW/yIZ1P8MCc//EQ3R/0pE3P/IxvT//////+Hf+f9nYOH/Jx7V/xgO0v8mHdX/KyLW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ykg1v8mHdb/JBvV/zUt2P9qY+L/hoDo/3hz5f84MNj/GhDS/xIJ0f8SC9H/EgrR/xQL0v8ZFNP/UEzd/6Gd7f/t7Pz/8fD8/7Ct8P87NNn/GRDS/yMZ1P8pH9b/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiLW/yce1v8eFdT/IxrV/1FL3f+/vPL/7Oz7/9bV9/+Ef+f/SkLc/yoi1v8iHNT/JB7V/zYt2f9cVeD/qqbv/+3s/P/y8f3/vLny/2lj4v8cFtP/Fw/S/ysi1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yce1f8cE9T/IhnV/1ZP3//NzPb/+/v+//n4/v/n5vr/x8X0/6aj7v+Vker/nJjs/7az8f/Y1/j/8/L9//Ly/f/EwvT/bGbj/yIZ1P8cE9P/IxrU/ysi1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ykg1v8lHNX/IhjU/zYu2P92ceX/q6fv/9TT9//39/3/+/v+/+/v/P/l4/r/6un7//X0/f/29v3/3dv4/6un7/9oYeL/LyfX/xQK0v8jGtX/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/ysi1v8tJNf/JBvV/xoR0/8cE9P/Rj/c/4N/5/+6uPH/19b3/+Ph+v/k4vr/5OL6/9rY+P+9uvL/ioXo/09I3f8cE9T/FAvS/yEY1P8qIdb/LCPX/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbxKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/KyLW/yge1v8eFdT/GhLT/yQd1P9AOdr/W1Xf/25o4/9ybOT/bWfj/15X4P9COtr/Jx/W/xkR0/8eFdT/JRzV/yoh1v8rItb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vEqIdbyKiHW+Coh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/LCPW/ysi1v8mHdX/HBPT/xYN0v8bEtP/IxrU/ykh1v8rItb/KSDW/yQa1f8bEtP/Fw3S/xkQ0/8lHNX/KyLW/ywj1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1vIqIdb0KiHW+Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8rItb/KyLW/ykg1v8jGdX/GxLT/xUL0v8TCtL/FQvS/xoR0/8jGtX/KSDW/ysi1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Soh1vQqIdb3KiHW+yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8pH9b/Jx7V/yUc1f8lHNX/JRzV/ycd1f8pINb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+yoh1vcqIdbsKiHW9Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/ysi1v8rItb/KyLW/ysi1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW9Soh1uwqIda9KiHW3Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW3Soh1r0qIdZcKiHWqyoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHWqyoh1lwqIdYbKiHWWyoh1q0qIdbXKiHW7ioh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW+Coh1vgqIdb4KiHW7ioh1tYqIdatKiHWWyoh1hsqIdYAKiHWHyoh1l4qIdavKiHW3ioh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW3ioh1q8qIdZeKiHWICoh1gCAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAABAAAoAAAAIAAAAEAAAAABACAAAAAAAAAQAAATCwAAEwsAAAAAAAAAAAAAKiHWACoh1kwqIdbFKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbFKiHWTCoh1gAqIdZFKiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHWRSoh1tQqIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdbVKiHW9yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1vgqIdbzKiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/y8l1/8cEtP/DwXR/w8F0f8PBdH/DwXR/w8F0f8PBdH/DwXR/w8F0f8PBdH/DwXR/w8F0f8eFNT/LyXX/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW8yoh1vEqIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/IxrV/0E52v9VTt7/VU7e/1VO3v9VTt7/VU7e/1VO3v9VTt7/VU7e/1VO3v9VTt7/VU7e/z012v8jGtX/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdbxKiHW8Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8DAM//pKHt////////////////////////////////////////////////////////////op7t/wAAzf8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1vEqIdbxKiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/wQAz/+gnO3//////+fn+v+qpu//trPx/7az8f+2s/H/trPx/7az8f+2s/H/trPx/7az8f9rZOP/EQvR/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW8Soh1vEqIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/BgDP/5eS6///////pKDu/wAAyf8LAND/CgDQ/woA0P8KAND/CgDQ/woA0P8KAND/CgDQ/xsS0/8wJtf/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdbxKiHW8Soh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8IAM//hoLo//////+4tPH/DgTQ/ygf1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1vEqIdbxKiHW/yoh1v8qIdb/KiHW/yoh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1v8qIdb/KiHW/xkQ0/84MNn/7e38////////////zMr1/66q7//OzPb///////////+opO7/DwXR/yAX1P8rItb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1vEqIdbxKiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/LiXX/xcN0v8fFtT/jIjp/+fn+v/////////////////U0/f/b2nj/w0D0f8cE9P/LSTX/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW8Soh1vEqIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/LiXX/x0U1P8IAM//KB/V/05H3f9VTt7/RT3b/xwS0/8IAND/JRzV/y0k1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdbxKiHW8yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KyLW/yoh1v8gFtT/EgjR/w8F0f8VC9L/JBvV/ysi1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1vMqIdb4KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW+Coh1tUqIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdbVKiHWRSoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1v8qIdb/KiHW/yoh1kUqIdYAKiHWSyoh1sQqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1vEqIdbxKiHW8Soh1sMqIdZLKiHWAIAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAB"
 
# Global variables
$global:storedPINCode = $null
$global:storedDeviceNumber = $null
Add-Type -AssemblyName System.Windows.Forms
# Function to show an input box
function Set-DataGridViewColumnWidths {
    param (
        [System.Windows.Forms.DataGridView]$dataGridView
    )

   $dataGridView.Columns | Foreach-Object{
    $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
}
	
}

# Example usage:
# Set-DataGridViewColumnWidths -dataGridView $yourDataGridView

 function Show-InputBox {
    param(
        [string]$prompt,
        [string]$title
    )

    # Create a form
    $inputForm = New-Object System.Windows.Forms.Form
    $inputForm.Text = $title
    $inputForm.Size = New-Object System.Drawing.Size(300, 150)
    $inputForm.StartPosition = "CenterParent"  # Set the StartPosition to CenterParent

    # Create a label
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $prompt
    $label.Location = New-Object System.Drawing.Point(5, 20)
	$label.size = New-Object System.Drawing.Size(200, 30)
    $inputForm.Controls.Add($label)

    # Create a password text box
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.PasswordChar = '*'  # Set the password character
    $textBox.UseSystemPasswordChar = $true  # Use the system password character
    $textBox.Location = New-Object System.Drawing.Point(20, 50)
    $inputForm.Controls.Add($textBox)

    # Create an OK button
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "OK"
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $okButton.Location = New-Object System.Drawing.Point(20, 80)
    $inputForm.Controls.Add($okButton)

    # Create an event handler for Enter key press
    $inputForm.KeyPreview = $true
    $inputForm.Add_KeyDown({
        param($sender, $e)
        if ($e.KeyCode -eq 'Enter') {
            $inputForm.DialogResult = [System.Windows.Forms.DialogResult]::OK
            $inputForm.Close()
        }
    })






    # Show the form
	$inputForm.Icon = [Drawing.Icon][IO.MemoryStream][Convert]::FromBase64String($Icon)
    $result = $inputForm.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        
		$global:storedPINCode = $textBox.Text
		
		return $textBox.Text
		
		
    }

    return $null
}


function RefreshButton_Click {
    # Implement the action you want to perform on refresh button click
    # For example, you might want to refresh the list of devices

    # Clear existing data
    $dataGrid.DataSource = $null
    $devicesDropdown.SelectedIndex = -1
    $devicesDropdown.Items.Clear()

    # Get the FIDO2 devices
    $devices = Get-FIDO2Devices

    # Add devices to the dropdown
    $devicesDropdown.Items.AddRange($devices)
	
	
	$statusLabel.Text = "status: ☑ ready"
}


function Get-Passkeys {
    
 # Debugging: Display the current values of global variables
       # Write-Host "Stored PIN Code: $global:storedPINCode"
       # Write-Host "Stored Device Number: $global:storedDeviceNumber"
    
        # Execute the fido2-manage.exe command with additional options (-residentKeys)
        $fido2ManageCommand = ".\fido2-manage.exe"
        $arguments = "-residentKeys", "-device", $global:storedDeviceNumber, "-pin", $global:storedPINCode
        $commandOutputResidentKeys = & $fido2ManageCommand $arguments

       # Write-Host "fido2-manage.exe Command Output (ResidentKeys):"
		 #  Write-Host "Executing command: $fido2ManageCommand $arguments"

       # Write-Host $commandOutputResidentKeys
		
		# Parse the output to treat each line as a separate item
        $parsedOutput = $commandOutputResidentKeys -split "`n"
		
        # Open a new form to display the DataGridView
        Show-PasskeysForm -parsedOutput $parsedOutput
 
		
		
	}	

# Function to show the Passkeys form with DataGridView
function Show-PasskeysForm {
    param (
        [array]$parsedOutput
    )
# Debugging: Display the count of items in the array
     
	 $form.Text = "FIDO2.1 Manager Ⓥ1.2.1"
	 $statusLabel.Text = "status: ⌛ loading"
	 
	 
	 
    # Create a new form
    $passkeysForm = New-Object Windows.Forms.Form
    $passkeysForm.Text = "Passkeys"
    $passkeysForm.Size = New-Object Drawing.Size(600, 400)
    $passkeysForm.StartPosition = "CenterParent"
    # Create a DataGridView control
    $dataGridView = New-Object Windows.Forms.DataGridView
    $dataGridView.Location = New-Object Drawing.Point(20, 20)
    $dataGridView.Size = New-Object Drawing.Size(550, 300)
    $passkeysForm.Controls.Add($dataGridView)

    # Create a DataTable to hold the data
    $dataTable = New-Object System.Data.DataTable

  # Add columns for Credential ID and User
    $columns = "ID", "Domain", "User"
    $columns | ForEach-Object {
        $column = New-Object System.Data.DataColumn($_)
		 
		
        $dataTable.Columns.Add($column)
		
    }
	
	
	
    # Add rows to the DataTable (filtering lines with values more than 10 characters)
     $parsedOutput | Where-Object { $_.Length -gt 10 } | ForEach-Object {
        $row = $dataTable.NewRow()

        # Split the line based on space
        $parts = $_ -split ' '

        # Set Domain value (last part)
        
		$domainI = $parts[-1]
        
		 # Execute the command to get resident keys
        $residentKeysCommand = ".\fido2-manage.exe -residentKeys -device $global:storedDeviceNumber -domain $domainI -pin $global:storedPINCode"
        $residentKeysOutput = Invoke-Expression $residentKeysCommand

		#Write-Host $residentKeysOutput
$residentKeysOutput -split "`r`n" | ForEach-Object {
    $row = $dataTable.NewRow()

    # Match the "Credential ID" and "User" values using regex
    $match = $_ -match 'Credential ID: (.+), User: (.+)'

    if ($match  ) {
        # Set Credential ID, User, and Domain values
		 $row["Domain"] = $domainI
        $row["ID"] = $matches[1].Trim()
       #$row["User"] = ($matches[2] -split ' ', 2)[0].Trim()
	   $row["User"] = $matches[2].Trim()

        if ($row["ID"].Length -gt 5) {
            $dataTable.Rows.Add($row)
        }
    }
}


		
    }

    # Set the DataGridView DataSource to the DataTable
    $dataGridView.DataSource = $dataTable
    Set-DataGridViewColumnWidths($dataGridView)
 
    # Show the form
	
	#$form.Text = "FIDO2.1 Manager Ⓥ1.2"
	$statusLabel.Text = "status: ☑ ready"
	
	# Create a button for the double-click action
    $buttonDoubleClick = New-Object System.Windows.Forms.Button
    $buttonDoubleClick.Text = "Delete"
    $buttonDoubleClick.Location = New-Object System.Drawing.Point(10, 330)
	 # Add a click event to the button
    $buttonDoubleClick.Add_Click({
        # Get the selected Credential ID
    $selectedCredentialID = $dataGridView.SelectedCells[0].Value
	$passkeysForm.Close()
$passkeysForm.Dispose()
    # Delete the passkey
    # Execute the fido2-manage.exe command to delete the credential in a new console window
    $deleteCommand = ".\fido2-manage.exe -delete -device $global:storedDeviceNumber -credential $selectedCredentialID -pin $global:storedPINCode"
    #Write-Host $deleteCommand
	# Start a new CMD process to execute the deletion command
    # Start CMD process
$process = Start-Process "cmd.exe" -ArgumentList "/c $deleteCommand" -PassThru

# Wait for the CMD process to exit
$process.WaitForExit()

# Now you can run Get-Passkeys or any other code you want to execute after CMD is closed
Get-Passkeys
	
	
    }
	
	
	)
	   $passkeysForm.Controls.Add($buttonDoubleClick)
	   $passkeysForm.Icon = [Drawing.Icon][IO.MemoryStream][Convert]::FromBase64String($Icon)
    $passkeysForm.ShowDialog()
}


# Function to show the ResidentKeys form with DataGridView
function Show-ResidentKeysForm {
    param (
        [string]$residentKeysOutput
    )

    # Create a new form
    $residentKeysForm = New-Object Windows.Forms.Form
    $residentKeysForm.Text = "Resident Keys"
    $residentKeysForm.Size = New-Object Drawing.Size(600, 400)

    # Create a DataGridView control
    $dataGridView = New-Object Windows.Forms.DataGridView
    $dataGridView.Location = New-Object Drawing.Point(20, 20)
    $dataGridView.Size = New-Object Drawing.Size(600, 300)
    $residentKeysForm.Controls.Add($dataGridView)

    # Create a DataTable to hold the data
    $dataTable = New-Object System.Data.DataTable

    # Add a column for the Resident Keys
    

    # Add columns for Credential ID and User
    $columns = "ID", "User"
    $columns | ForEach-Object {
        $column = New-Object System.Data.DataColumn($_)
        $dataTable.Columns.Add($column)
    }

   # Parse the ResidentKeysOutput and add rows to the DataTable
$residentKeysOutput -split "`r`n" | ForEach-Object {
    $row = $dataTable.NewRow()

    # Match the "Credential ID" and "User" values using regex
    $match = $_ -match 'Credential ID: (.+), User: (.+)'

    if ($match) {
        # Set Credential ID and User values
        $row["ID"] = $matches[1].Trim()
        $row["User"] = $matches[2].Trim()

        $dataTable.Rows.Add($row)
    }
}

# Set the DataGridView DataSource to the DataTable
$dataGridView.DataSource = $dataTable
$dataGridView.Columns | ForEach-Object {
    $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
}

Set-DataGridViewColumnWidths($dataGridView)

 

# Create a button for the delete action
    $buttonDeleteCredential = New-Object System.Windows.Forms.Button
    $buttonDeleteCredential.Text = "Delete"
    $buttonDeleteCredential.Location = New-Object System.Drawing.Point(10, 330)
	 $buttonDeleteCredential.Add_Click({
	# Get the selected credential ID
    $selectedRowIndex = $dataGridView.SelectedCells[0].RowIndex
    $selectedCredentialID = $dataGridView.Rows[$selectedRowIndex].Cells["ID"].Value

    # Show the Credential ID in a MessageBox
    [System.Windows.Forms.MessageBox]::Show("Selected Credential ID: $selectedCredentialID", "Credential ID")
	
	# Execute the fido2-manage.exe command to delete the credential in a new console window
    $deleteCommand = ".\fido2-manage.exe -delete -device $global:storedDeviceNumber -credential $selectedCredentialID -pin $global:storedPINCode"
    #Write-Host $deleteCommand
	# Start a new CMD process to execute the deletion command
    Start-Process "cmd.exe" -ArgumentList "/c $deleteCommand"
	# Close the current form after CMD command execution
    $residentKeysForm.Close()
	$passkeysForm.Close()
	  # Refresh the passkeys form
    Show-PasskeysForm $selectedDevice $global:storedPINCode
	
})
	 
		 
     $residentKeysForm.Controls.Add($buttonDeleteCredential)
    # Show the form
    $residentKeysForm.ShowDialog()
}
# Function to execute the fido2-manage.exe command and parse the results
function Get-FIDO2Devices {
    $commandOutput = & ".\fido2-manage.exe" -list 2>&1
    $devices = $commandOutput | Where-Object { $_ -match "Device \[\d\] : " } | ForEach-Object {
        $_ -replace "Device \[(\d+)\] : (.*)", '$1 - $2'
    }

    return $devices
}

# Main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "FIDO2.1 Manager Ⓥ1.2.1"

$form.Size = New-Object System.Drawing.Size(650, 380)
 
$form.minimumSize = New-Object System.Drawing.Size(650, 380)
$form.maximumSize = New-Object System.Drawing.Size(650, 380)


 $form.Icon = [Drawing.Icon][IO.MemoryStream][Convert]::FromBase64String($Icon)
 

# List of devices
$devicesLabel = New-Object System.Windows.Forms.Label
$devicesLabel.Text = "List of Devices:"
$devicesLabel.Location = New-Object System.Drawing.Point(20, 14)
$form.Controls.Add($devicesLabel)

# List of devices
$infoLabel = New-Object System.Windows.Forms.Label
$infoLabel.Width = 400  # Set the desired width
$CopyFont = [System.Drawing.Font]::new('Segoe UI', 8, [System.Drawing.FontStyle]::Italic)
$infoLabel.Font= $CopyFont
$infoLabel.Text = "GUI for FIDO2.1 Security key management tool (c) Token2 Sàrl , Switzerland "
$infoLabel.Location = New-Object System.Drawing.Point(10, 320)
$form.Controls.Add($infoLabel)



# Data
$dataLabel = New-Object System.Windows.Forms.Label
$dataLabel.Text = "Device info:"
$dataLabel.Location = New-Object System.Drawing.Point(20, 87)
$form.Controls.Add($dataLabel)

 


# Function to show relying parties form (placeholder for now)
function Show-RelyingPartiesForm {
    param($selectedDevice)


# Loading - Wait

$statusLabel.Text = "status: ⌛ loading"


    $deviceNumber = $selectedDevice -replace '(\d+).*', '$1'
$global:storedDeviceNumber = $deviceNumber
    do {
        # Ask for a PIN code using the input box function
        $pinCode = Show-InputBox -prompt "Enter PIN Code:`r`n[enter 0000 if no PIN is set for this key]" -title "PIN Code"
        
        if ($pinCode -eq $null) {
            # User canceled input, exit the loop
            return
        }

        if ($pinCode -eq "") {
            [System.Windows.Forms.MessageBox]::Show("PIN Code cannot be empty. Please enter a valid PIN.", "Invalid PIN", 0)
			
			
        }
    } while ($pinCode -eq "")

    # Implement logic to show the next form or perform the next action with $deviceNumber and $pinCode
    #Write-Host "Selected Device Number: $deviceNumber"
    
$dataGrid.DataSource = $null






	# Execute the fido2-manage.exe command with additional options
$fido2ManageCommand = ".\fido2-manage.exe"
$arguments = "-pin", $pinCode, "-info", "-device", $deviceNumber
$commandOutput = & $fido2ManageCommand $arguments 2>&1
 







 
 # Execute the fido2-manage.exe command with additional options (-storage)
   # $arguments = "-pin", $pinCode, "-storage", "-device", $deviceNumber
   $arguments = "-pin", "`"$pinCode`"", "-storage", "-device", $deviceNumber
    $commandOutputStorage = & $fido2ManageCommand $arguments 2>&1
	
 ##Check if UV is Supported
  
 

 
 
 
 ## ENd check UV
	
  # Add a new row to the DataTable (replace with actual data)
  $dataTable = New-Object System.Data.DataTable
  # Add columns to the DataTable
$dataTable.Columns.Add("Property")
$dataTable.Columns.Add("Value")
$changePINButton.Enabled = $false 
$setPINButton.Enabled = $false
	#Write-Host $commandOutputStorage
		# Check if key or value contains FIDO_ERR_PIN_REQUIRED
   if ($commandOutputStorage -match "FIDO_ERR_PIN_REQUIRED") {
    [System.Windows.Forms.MessageBox]::Show("This security key does not have a PIN set. This is a requirement to be able to manage this device. Click on 'Set PIN' to set a PIN for this key. ", "PIN Required", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
   $setPINButton.Enabled = $true
   $changePINButton.Enabled = $false 
   $form.Text = "FIDO2.1 Manager Ⓥ1.2.1"
   $statusLabel.Text = "status: ☑ ready"
   return
}
		
		 if ($commandOutputStorage -match "FIDO_ERR_PIN_INVALID") {
			
			 [System.Windows.Forms.MessageBox]::Show("Invalid PIN was provided", "Wrong PIN", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
			 
			   $devicesDropdown.SelectedIndex = -1
        Get-FIDO2Devices
		$form.Text = "FIDO2.1 Manager Ⓥ1.2.1"
		$statusLabel.Text = "status: ☑ ready"
	return
			}


 
 
 
if ( $commandOutputStorage -match "FIDO_ERR_INVALID_CBOR") {  

$mergedOutput = $commandOutput # You can replace "Default value" with whatever is appropriate
   
} else {
	 
    
	
	 $mergedOutput = $commandOutputStorage + "`n" + $commandOutput
	 
}
		
  

$parsedOutput = @{}

$relyingPartiesButton.Enabled = $false
$resetButton.Enabled = $false
		
	
		
		
    foreach ($line in $mergedOutput -split "`n") {
        $lineParts = $line -split ":", 2
		
		if ($line -match '\[Info\]') {
            continue
        }
		
        if ($lineParts.Count -eq 2) {
            $key = $lineParts[0].Trim()
            $value = $lineParts[1].Trim()
            $parsedOutput[$key] = $value
			
			
		
			if ($key -eq "existing rk(s)") {
                    $key = "used passkey slots"
					$relyingPartiesButton.Enabled = $true
					$resetButton.Enabled = $true
					$changePINButton.Enabled = $true 
					$usedSlots = [int]$value
                }
                elseif ($key -eq "remaining rk(s)") {
                    $key = "free passkey slots"
					 $freeSlots = [int]$value
                }
			
			 $newRow = $dataTable.NewRow()
    $newRow["Property"] = $key
    $newRow["Value"] = $value
    $dataTable.Rows.Add($newRow)
	
	  if ($key -eq "free passkey slots") {
	# Calculate total slots and add as a separate entry
$totalSlots = $usedSlots + $freeSlots
$newRow = $dataTable.NewRow()
$newRow["Property"] = "total passkey slots"
$newRow["Value"] = $totalSlots.ToString()
$dataTable.Rows.Add($newRow)



	 }
		
	
        }
    }
	
 #If Data is empty allow setting PIN
 
 
	if ($usedSlots -eq 0) {
 
	$relyingPartiesButton.Enabled = $false
}
	 
   

    $dataGrid.DataSource = $dataTable
	
	$dataGrid.Columns | Foreach-Object{
    $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
}

Set-DataGridViewColumnWidths( $dataGrid)
#Loaded

$form.Text = "FIDO2.1 Manager Ⓥ1.2.1"
$statusLabel.Text = "status: ☑ ready"
}


# DataGrid
$dataGrid = New-Object System.Windows.Forms.DataGridView
$dataGrid.Location = New-Object System.Drawing.Point(20, 110)
$dataGrid.Size = New-Object System.Drawing.Size(600, 150)
$dataGrid.AllowUserToAddRows = $false  # Optional: Disable the ability to add new rows

 # Button for relying parties
 $ClickedFont = [System.Drawing.Font]::new('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
    $relyingPartiesButton = New-Object System.Windows.Forms.Button
    $relyingPartiesButton.Text = "show passkeys"
	
    $relyingPartiesButton.Width = 140
	 $relyingPartiesButton.Font =  $ClickedFont
    $relyingPartiesButton.Location = New-Object System.Drawing.Point(20, 280)
    $relyingPartiesButton.Enabled = $false;
    $relyingPartiesButton.Add_Click({
      
        Get-Passkeys
    })
    $form.Controls.Add($relyingPartiesButton)
# Button for reset
$resetButton = New-Object System.Windows.Forms.Button
$resetButton.Text = "Reset"
$resetButton.ForeColor = [System.Drawing.Color]::Red
$resetButton.Enabled = $false;
$resetButton.Location = New-Object System.Drawing.Point(540, 280)
$resetButton.Add_Click({
    # Ask for user confirmation
    $confirmation = [System.Windows.Forms.MessageBox]::Show("Please unplug your key and plug it back before continuing. You can reset the key only within 10 seconds after it was plugged. Also note that this operation will delete all data, including passkeys and PIN. Click on Yes to continue. ", "Confirmation", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)

    if ($confirmation -eq [System.Windows.Forms.DialogResult]::Yes) {
        # Implement the action to launch .\fido2-manage.exe -reset -device ...
        $resetCommand = ".\fido2-manage.exe -reset -device $global:storedDeviceNumber"
		#Write-Host $resetCommand
        $dataGrid.DataSource = $null

        # Execute the reset command
        Start-Process "cmd.exe" -ArgumentList "/c $resetCommand" -Wait

        # Refresh the FIDO2 devices
		 # Clear the selection in the ComboBox
        $devicesDropdown.SelectedIndex = -1
		$setPINButton.Enabled = $false
		$resetButton.Enabled = $false
		$setPINButton.Enabled = $false
		$relyingPartiesButton.Enabled = $false
		$changePINButton.Enabled = $false
		$dataGrid.DataSource = $null
        Get-FIDO2Devices
    }
})


# Create a button for changing PIN
$changePINButton = New-Object System.Windows.Forms.Button
$changePINButton.Text = "Change PIN"
$changePINButton.Location = New-Object System.Drawing.Point(320, 280)
$changePINButton.Enabled = $false  # Disable the button by default
$changePINButton.Add_Click({
    # Implement the action you want to perform on Change PIN button click
    # For example, you might want to open a form to input the new PIN
    # Placeholder: Add your code here
	
	 # Implement the action to launch .\fido2-manage.exe -reset -device ...
        $resetCommand = ".\fido2-manage.exe -changePIN -device $global:storedDeviceNumber"
		#Write-Host $resetCommand
        $dataGrid.DataSource = $null

        # Execute the reset command
        Start-Process "cmd.exe" -ArgumentList "/c $resetCommand" -Wait

        # Refresh the FIDO2 devices
		 # Clear the selection in the ComboBox
        $devicesDropdown.SelectedIndex = -1
		$setPINButton.Enabled = $false
		$resetButton.Enabled = $false
		$setPINButton.Enabled = $false
		$relyingPartiesButton.Enabled = $false
		$changePINButton.Enabled = $false
        Get-FIDO2Devices
		
		
})

# Add the Change PIN button to the form
$form.Controls.Add($changePINButton)



# Button for Set PIN
$setPINButton = New-Object System.Windows.Forms.Button
$setPINButton.Text = "Set PIN"
$setPINButton.Location = New-Object System.Drawing.Point(240, 280)
$setPINButton.Enabled = $false  # Disabled by default

# Add_Click event for Set PIN button
$setPINButton.Add_Click({
	
	   # Implement the action to launch .\fido2-manage.exe -reset -device ...
        $resetCommand = ".\fido2-manage.exe -device $global:storedDeviceNumber -setPIN"
		#Write-Host $resetCommand
        $dataGrid.DataSource = $null

        # Execute the reset command
        Start-Process "cmd.exe" -ArgumentList "/c $resetCommand" -Wait

        # Refresh the FIDO2 devices
		 # Clear the selection in the ComboBox
        $devicesDropdown.SelectedIndex = -1
        Get-FIDO2Devices
		$setPINButton.Enabled = $false
     
    
})


$form.Controls.Add($setPINButton)


$form.Controls.Add($resetButton)


$form.Controls.Add($dataGrid)
# Set up data bindings


# Create a Refresh button
$refreshButton = New-Object System.Windows.Forms.Button
$refreshButton.Text = "Refresh"
$refreshButton.Location = New-Object System.Drawing.Point(430, 38)
$form.Controls.Add($refreshButton)

# Add a click event to the Refresh button
$refreshButton.Add_Click({
    # Implement the action you want to perform on refresh button click
    # For example, you might want to refresh the list of devices
	$dataGrid.DataSource = $null
	$devicesDropdown.SelectedIndex = -1
$devicesDropdown.Items.Clear()
$devices = Get-FIDO2Devices
$devicesDropdown.Items.AddRange($devices)
   
})

 # List of devices
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "status: ⌛ loading"
$statusLabel.Location = New-Object System.Drawing.Point(530, 320)
 
$form.Controls.Add($statusLabel)


$devicesDropdown = New-Object System.Windows.Forms.ComboBox
$devicesDropdown.Location = New-Object System.Drawing.Point(20, 40)
$devicesDropdown.Width = 400
$form.Controls.Add($devicesDropdown)

# Event handler for device selection
$devicesDropdown.Add_SelectedIndexChanged({
    $selectedDevice = $devicesDropdown.SelectedItem
    if ($selectedDevice) {
        # Call the next function or form to proceed with the selected device
        Show-RelyingPartiesForm $selectedDevice
    }
})

$form.Add_Shown({
    Start-Sleep -Seconds 2
    RefreshButton_Click
})
 
# Show the form
$form.ShowDialog()  | Out-Null
 
 
