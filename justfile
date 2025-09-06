# Usa bash
set shell := ["bash", "-eu", "-o", "pipefail", "-c"]


# ================================================================== VARIABLES =

EPHEMERAL_FOLDER := env_var_or_default("EPHEMERAL_FOLDER", "ephemeral-cluster")

HOST  := env_var_or_default("HOST", "root-cluster")

VNAME := env_var_or_default("VNAME", "temporal-cluster")
VPORT := env_var_or_default("VPORT", "6000")



# =============================================================== ROOT CLUSTER =

cluster-create:
    @cd {{EPHEMERAL_FOLDER}} && just cluster-create

cluster-delete:
    @cd {{EPHEMERAL_FOLDER}} && just cluster-delete

cluster-connect:
    @cd {{EPHEMERAL_FOLDER}} && just cluster-connect



# ============================================================ VIRTUAL CLUSTER =

vcluster-full:
    @cd {{EPHEMERAL_FOLDER}} && just vcluster-full

vcluster-delete:
    @cd {{EPHEMERAL_FOLDER}} && just vcluster-delete

vcluster-test:
    #!/usr/bin/env bash
    cd {{EPHEMERAL_FOLDER}}

    VNAME="first-deploy" VPORT="4000" just vcluster-full
    VNAME="second-deploy" VPORT="5000" just vcluster-full



# ======================================================================== ALL =

all: cluster-create vcluster-test