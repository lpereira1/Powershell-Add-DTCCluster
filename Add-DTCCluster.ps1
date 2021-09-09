<#
.SYNOPSIS
   This function will activate DTC based on the provided paramters

.DESCRIPTION
    Add-DTCCluster is a function that intakes all the inputs required to build a 
    DTC Cluster Service. 

.PARAMETER ClusterName
    The Windows failover cluster name.

.PARAMETER DTCDiskName
    Name of the disk resource to use with DTC

.PARAMETER DTCDNSName
    Name for DTC in DNS.

.PARAMETER DTCResourceGroup
    Name of the DTC resource group

.PARAMETER DTCIpAddr
    IP address for use by DTC

.PARAMETER DTCSubnet
    Subnet mask for DTC

.PARAMETER DTCIpName
    Name of the DTC IP address resource

.PARAMETER DTCNetworkName
    Name of the DTC network name resource

.PARAMETER DTCResourceName
    Name of the DTC resource name

.EXAMPLE
     Add-DTCCluster -ClusterName 'DTCCluster1'-DTCDiskName 'MSDTC' -DTCDNSName 'DTCCluster1.domain.com'  -DTCResourceGroup 'DTCResourceGroup' -DTCIpAddr 10.1.1.1 -DTCSubnet 255.255.255.0 -DTCIpName 'DTCIPName1' -DTCNetworkName 'DTCNetwork1' -DTCResourceName 'DTCResource1'

.INPUTS
    String

.OUTPUTS
    PSCustomObject

.NOTES
    Author:  Lazaro Pereira
    Website: http://github.com/lpereira1
    Twitter: @routesnmore
#>
param (
     # "Windows failover cluster name"
     [Parameter(Mandatory)]
     [string]$ClusterName,
     # "Name of the disk resource to use with DTC"
     [Parameter(Mandatory)]
     [string]$DTCDiskName,
     # "Name for DTC in DNS"
     [Parameter(Mandatory)]
     [string]$DTCDNSName,
     # "Name of the DTC resource group"
     [Parameter(Mandatory)]
     [string]$DTCResourceGroup,
     # "IP address for DTC"
     [Parameter(Mandatory)]
     [string]$DTCIpAddr,
     # “Subnet mask for DTC"
     [Parameter(Mandatory)]
     [string]$DTCSubnet, 
     # “Name of the DTC IP address resource"
     [Parameter(Mandatory)]
     [string]$DTCIpName,
     # “Name of the DTC network name resource"
     [Parameter(Mandatory)]
     [string]$DTCNetworkName,
     # “Name of the DTC resource name"
     [Parameter(Mandatory)]
     [string]$DTCResourceName
 )

function Add-DTCCluster{


    [CmdletBinding()]
    param (
        # “Windows failover cluster name"
        [Parameter(Mandatory)]
        [string]$ClusterName,
        # “Name of the disk resource to use with DTC"
        [Parameter(Mandatory)]
        [string]$DTCDiskName,
        # “Name for DTC in DNS"
        [Parameter(Mandatory)]
        [string]$DTCDNSName,
        # “Name of the DTC resource group"
        [Parameter(Mandatory)]
        [string]$DTCResourceGroup,
        # “IP address for DTC"
        [Parameter(Mandatory)]
        [string]$DTCIpAddr,
        # “Subnet mask for DTC"
        [Parameter(Mandatory)]
        [string]$DTCSubnet, 
        # “Name of the DTC IP address resource"
        [Parameter(Mandatory)]
        [string]$DTCIpName,
        # “Name of the DTC network name resource"
        [Parameter(Mandatory)]
        [string]$DTCNetworkName,
        # “Name of the DTC resource name"
        [Parameter(Mandatory)]
        [string]$DTCResourceName
    )
     Add-ClusterGroup $DTCResourceGroup -Cluster $ClusterName
     Add-ClusterResource $DTCIpName -ResourceType "IP Address" -Cluster $ClusterName -Group $DTCResourceGroup
     $ipres = Get-ClusterResource $DTCIpName
     $ipaddr = New-Object Microsoft.FailoverClusters.PowerShell.ClusterParameter $ipres,Address,$DTCIpAddr
     $subnet = New-Object Microsoft.FailoverClusters.PowerShell.ClusterParameter $ipres,Address,$DTCSubnet
     $setparams = $ipaddr,$subnet
     $setparams | Set-ClusterParameter
     Add-ClusterResource $DTCNetworkName -ResourceType "Network name" -Cluster $ClusterName -Group $dtc_resource_group
     $nnres = Get-ClusterResource $DTCNetworkName
     $netnm = New-Object Microsoft.FailoverClusters.PowerShell.ClusterParameter $nnres,Address,$DTCDNSName
     $netnm | Set-ClusterParameter
     Add-ClusterResourceDependency $DTCNetworkName $DTCIpName -Cluster $ClusterName
     Add-ClusterResource $DTCResourceName -ResourceType "Distributed Transaction Coordinator" -Cluster $ClusterName -Group $dtc_resource_group
     Add-ClusterResourceDependency $DTCResourceName $DTCNetworkName -Cluster $ClusterName
     Move-ClusterResource $DTCDiskName -Cluster $ClusterName -Group $dtc_resource_group
     Add-ClusterResourceDependency $DTCResourceName $DTCDiskName -Cluster $ClusterName

}

Add-DTCCluster -ClusterName $ClusterName -DTCDiskName 'MSDTC' -DTCDNSName 'DTCCluster1.domain.com'  -DTCResourceGroup 'DTCResourceGroup' -DTCIpAddr 10.1.1.1 -DTCSubnet 255.255.255.0 -DTCIpName 'DTCIPName1' -DTCNetworkName 'DTCNetwork1' -DTCResourceName 'DTCResource1'
