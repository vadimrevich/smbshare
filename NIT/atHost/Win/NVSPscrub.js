/*
Copyright (c) Microsoft Corporation
 
Module Name:
 
    nvspscrub.js
 
*/

//
// VirtualSwitchManagementService object.  Logical wrapper class for Switch Management Service
//
function
VirtualSwitchManagementService(
    Server,
    User,
    Password
    )
{
    //
    // Define instance fields.
    //   
    this.m_VirtualizationNamespace  = null;
   
    this.m_VirtualSwitchManagementService = null;
       

    //
    // Instance methods
    //       
   
    VirtualSwitchManagementService.prototype.DeleteSwitch =
    function(
        VirtualSwitch
        )
       
    /*++

    Description:

        Deletes a virtual switch
       
    Arguments:

        VirtualSwitch – Msvm_VirtualSwitch object to delete

    Return Value:

        SWbemMethod.OutParameters object.

    –*/
   
    {
        var methodName = "DeleteSwitch";

        var inParams = this.m_VirtualSwitchManagementService.Methods_(methodName).inParameters.SpawnInstance_();

        inParams.VirtualSwitch = VirtualSwitch.Path_.Path;
       
        return this.m_VirtualSwitchManagementService.ExecMethod_(methodName, inParams);
    }
   
   
    VirtualSwitchManagementService.prototype.DeleteInternalEthernetPort =
    function(
        InternalEthernetPort
        )

    /*++

    Description:

        Deletes an internal ethernet port
       
    Arguments:

        InternalEthernetPort – Msvm_InternalEthernetPort to delete
       
    Return Value:

        SWbemMethod.OutParameters object.

    –*/

    {
        var methodName = "DeleteInternalEthernetPort";

        var inParams = this.m_VirtualSwitchManagementService.Methods_(methodName).inParameters.SpawnInstance_();
       
        inParams.InternalEthernetPort = InternalEthernetPort.Path_.Path;
       
        return this.m_VirtualSwitchManagementService.ExecMethod_(methodName, inParams);
    }
   
    VirtualSwitchManagementService.prototype.UnbindExternalEthernetPort =
    function(
        ExternalEthernetPort
        )

    /*++

    Description:

        Unbinds an external ethernet port from the virtual network subsystem.  Usually this method
         won’t be called directly
       
    Arguments:

        SwitchPort – Msvm_ExternalEthernetPort to unbind.

    Return Value:

        SWbemMethod.OutParameters object.

    –*/

    {
        var methodName = "UnbindExternalEthernetPort";

        var inParams = this.m_VirtualSwitchManagementService.Methods_(methodName).inParameters.SpawnInstance_();

        inParams.ExternalEthernetPort = ExternalEthernetPort.Path_.Path;
       
        return this.m_VirtualSwitchManagementService.ExecMethod_(methodName, inParams);
    }
   
    //
    // Utility functions
    //
   
    VirtualSwitchManagementService.prototype.WaitForNetworkJob =
    function(
        OutParams
        )

    /*++

    Description:

        WMI calls will exit with some type of return result.  Some will require
        a little more processing before they are complete. This handles those
        states after a wmi call.

    Arguments:

        OutParams – the parameters returned by the wmi call.

    Return Value:

        Status code

    –*/

    {
        if (OutParams.ReturnValue == 4096)
        {
            var jobStateStarting        = 3;
            var jobStateRunning         = 4;
            var jobStateCompleted       = 7;
   
            var networkJob;

            do
            {
                WScript.Sleep(1000);
               
                networkJob = this.m_VirtualizationNamespace.Get(OutParams.Job);

            } while ((networkJob.JobState == jobStateStarting) ||
                     (networkJob.JobState == jobStateRunning));

            if (networkJob.JobState != jobStateCompleted)
            {
                throw(new Error(networkJob.ErrorCode,
                                networkJob.Description + " failed: " + networkJob.ErrorDescription));
            }
           
            return networkJob.ErrorCode;
        }

        return OutParams.ReturnValue;
    }
   
    VirtualSwitchManagementService.prototype.GetSingleObject =
    function(
        SWbemObjectSet
        )

    /*++

    Description:

        Takes a SWbemObjectSet which is expected to have one object and returns the object

    Arguments:

        SWbemObjectSet – The set.

    Return Value:

        The lone member of the set.  Exception thrown if Count does not equal 1.

    –*/

    {
        if (SWbemObjectSet.Count != 1)
        {
            throw(new Error(5, "SWbemObjectSet was expected to have one item but actually had " + SWbemObjectSet.Count));
        }
       
        return SWbemObjectSet.ItemIndex(0);
    }

   
    //
    // Aggregate functions
    //
    VirtualSwitchManagementService.prototype.DeleteSwitchAndWait =
    function(
        VirtualSwitch
        )
       
    /*++

    Description:

        Deletes a switch
       
    Arguments:

        VirtualSwitch – Msvm_VirtualSwitch to delete
       
    Return Value:
   
        None.

    –*/
   
    {
        var outParams = this.DeleteSwitch(VirtualSwitch);

        var wmiRetValue = this.WaitForNetworkJob(outParams);

        if (wmiRetValue != 0)
        {
            throw(new Error(wmiRetValue, "DeleteSwitch failed"));
        }
    }
   
    VirtualSwitchManagementService.prototype.DeleteInternalEthernetPortAndWait =
    function(
        InternalEthernetPort
        )
    /*++

    Description:

        Deletes an internal ethernet port
       
    Arguments:

        InternalEthernetPort – Msvm_InternalEthernetPort to delete
       
    Return Value:

        SWbemMethod.OutParameters object.

    –*/
   
    {
        var outParams = this.DeleteInternalEthernetPort(InternalEthernetPort);

        var wmiRetValue = this.WaitForNetworkJob(outParams);

        if (wmiRetValue != 0)
        {
            throw(new Error(wmiRetValue, "DeleteInternalEthernetPortAndWait failed"));
        }
    }
   
   
    VirtualSwitchManagementService.prototype.UnbindExternalEthernetPortAndWait =
    function(
        ExternalEthernetPort
        )
    /*++

    Description:

        unbinds an internal ethernet port
       
    Arguments:

        ExternalEthernetPort – Msvm_ExternalEthernetPort to unbind
       
    Return Value:

        SWbemMethod.OutParameters object.

    –*/
   
    {
        var outParams = this.UnbindExternalEthernetPort(ExternalEthernetPort);

        var wmiRetValue = this.WaitForNetworkJob(outParams);

        if (wmiRetValue != 0)
        {
            throw(new Error(wmiRetValue, "UnbindExternalEthernetPortAndWait failed"));
        }
    }
   
    //
    // Constructor code
    //
   
    if (Server == null)
    {
        Server = WScript.CreateObject("WScript.Network").ComputerName;
    }
   
    //
    // Set Namespace fields
    //
    try
    {
        var locator = new ActiveXObject("WbemScripting.SWbemLocator");

        this.m_VirtualizationNamespace = locator.ConnectServer(Server, "root\virtualization", User, Password);
    }
    catch (e)
    {
        this.m_VirtualizationNamespace = null;
       
        throw(new Error("Unable to get an instance of Virtualization namespace: " + e.description));
    }
   
    //
    // Set Msvm_VirtualSwitchManagementService field
    //
    try
    {
        var physicalComputerSystem =
                this.m_VirtualizationNamespace.Get(
                        "Msvm_ComputerSystem.CreationClassName=’Msvm_ComputerSystem’,Name=’" + Server + "’");
         
        this.m_VirtualSwitchManagementService = this.GetSingleObject(
                                                        physicalComputerSystem.Associators_(
                                                            "Msvm_HostedService",
                                                            "Msvm_VirtualSwitchManagementService",
                                                            "Dependent"));
    }
    catch (e)
    {
        this.m_VirtualSwitchManagementService = null;
       
        throw(new Error("Unable to get an instance of Msvm_VirtualSwitchManagementService: " + e.description));
    }
}

//
// main
//

var wshShell = WScript.CreateObject("WScript.Shell");

var g_NvspWmi   = null;

Main();

function Main()
{
 WScript.Echo("Looking for nvspwmi…");
 g_NvspWmi   = new VirtualSwitchManagementService();

 WScript.Echo("");
 WScript.Echo("Looking for internal (host) virtual nics…");
 var list = g_NvspWmi.m_VirtualizationNamespace.ExecQuery("SELECT * FROM Msvm_InternalEthernetPort");
 for (i = 0; i < list.Count; i++)
 {
  var next = list.ItemIndex(i);
  WScript.echo(next.DeviceID);
  g_NvspWmi.DeleteInternalEthernetPortAndWait(next);
 }
 
 WScript.Echo("");
 WScript.Echo("Looking for switches…");
 list = g_NvspWmi.m_VirtualizationNamespace.ExecQuery("SELECT * FROM Msvm_VirtualSwitch");
 for (i = 0; i < list.Count; i++)
 {
  var next = list.ItemIndex(i);
  WScript.echo(next.Name);
  g_NvspWmi.DeleteSwitchAndWait(next);
 }
 
 WScript.Echo("");
 WScript.Echo("Looking for external nics…");
 list = g_NvspWmi.m_VirtualizationNamespace.ExecQuery("SELECT * FROM Msvm_ExternalEthernetPort WHERE IsBound=TRUE");
 for (i = 0; i < list.Count; i++)
 {
  var next = list.ItemIndex(i);
  WScript.echo(next.DeviceID);
  g_NvspWmi.UnbindExternalEthernetPortAndWait(next);
 }
 
 WScript.Echo("");
 WScript.Echo("Finished!");
}