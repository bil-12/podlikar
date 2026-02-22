#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== PodLikar Test Scenarios ==="
echo ""
echo "Deploying test namespace and failure scenarios..."
echo ""

kubectl apply -f "$SCRIPT_DIR/01-oomkilled.yaml"
echo "[1/6] OOMKilled scenario deployed"

kubectl apply -f "$SCRIPT_DIR/02-bad-entrypoint.yaml"
echo "[2/6] Bad entrypoint scenario deployed"

kubectl apply -f "$SCRIPT_DIR/03-imagepull-backoff.yaml"
echo "[3/6] ImagePullBackOff scenario deployed"

kubectl apply -f "$SCRIPT_DIR/04-probe-failure.yaml"
echo "[4/6] Liveness probe failure scenario deployed"

kubectl apply -f "$SCRIPT_DIR/05-missing-configmap.yaml"
echo "[5/6] Missing ConfigMap scenario deployed"

kubectl apply -f "$SCRIPT_DIR/06-dependency-ordering.yaml"
echo "[6/6] Dependency ordering scenario deployed"

echo ""
echo "All scenarios deployed. Wait ~30 seconds for failures to manifest."
echo "Then test with:"
echo "  kagent invoke -t 'health check' --agent podlikar"
echo ""
echo "To clean up:"
echo "  kubectl delete namespace podlikar-test"
