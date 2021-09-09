# Powershell-Add-DTCCluster
Add a Distributed Transaction Coordinator using powershell

## SYNOPSIS
   This script will activate DTC based on the provided paramters

## DESCRIPTION
    Add-DTCCluster is a function that intakes all the inputs required to build a 
    DTC Cluster Service. 

#### PARAMETER ClusterName
    The Windows failover cluster name.

#### PARAMETER DTCDiskName
    Name of the disk resource to use with DTC

#### PARAMETER DTCDNSName
    Name for DTC in DNS.

#### PARAMETER DTCResourceGroup
    Name of the DTC resource group

#### PARAMETER DTCIpAddr
    IP address for use by DTC

#### PARAMETER DTCSubnet
    Subnet mask for DTC

#### PARAMETER DTCIpName
    Name of the DTC IP address resource

#### PARAMETER DTCNetworkName
    Name of the DTC network name resource

#### PARAMETER DTCResourceName
    Name of the DTC resource name

### EXAMPLE
     Add-DTCCluster -ClusterName 'DTCCluster1'-DTCDiskName 'MSDTC' -DTCDNSName 'DTCCluster1.domain.com'  -DTCResourceGroup 'DTCResourceGroup' -DTCIpAddr 10.1.1.1 -DTCSubnet 255.255.255.0 -DTCIpName 'DTCIPName1' -DTCNetworkName 'DTCNetwork1' -DTCResourceName 'DTCResource1'

#### INPUTS
    String

#### OUTPUTS
    PSCustomObject
