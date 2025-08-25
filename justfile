# Usa bash
set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

# --- Variables 
HOST  := env_var_or_default("HOST", "root-cluster")
VNAME := env_var_or_default("VNAME", "temporal-cluster")
VPORT := env_var_or_default("VPORT", "6000")

EPHEMERAL_FOLDER := env_var_or_default("EPHEMERAL_FOLDER", "ephemeral-cluster")

# -------------------------------------------------------------------- cluster -
cluster-create:
    @cd {{EPHEMERAL_FOLDER}} && just cluster-create

cluster-delete:
    @cd {{EPHEMERAL_FOLDER}} && just cluster-delete

cluster-connect:
    @cd {{EPHEMERAL_FOLDER}} && just cluster-connect

# ------------------------------------------------------------------- vcluster -
vcluster-full:
    @cd {{EPHEMERAL_FOLDER}} && just vcluster-full

vcluster-delete:
    @cd {{EPHEMERAL_FOLDER}} && just vcluster-delete

vcluster-test:
    #!/usr/bin/env bash
    cd {{EPHEMERAL_FOLDER}}

    VNAME="first-deploy" VPORT="4000" just vcluster-full
    VNAME="second-deploy" VPORT="5000" just vcluster-full

# ------------------------------------------------------------------------ all -
all: cluster-create vcluster-test