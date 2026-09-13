import tempfile
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).parents[1]))
from mishrin_ai.policy_engine import UniversalFreeAIPolicy


def make_policy():
    data = {
        "version": "1.0.0",
        "core_access": "free",
        "subscription_required": False,
        "fair_use": {"enabled": True, "purpose": "capacity_and_abuse_prevention", "no_hidden_paywall": True},
        "third_party": {"authorized_apis_only": True, "bypass_authentication": False,
                         "bypass_pricing": False, "bypass_rate_limits": False, "bypass_security": False},
        "safety": {"enabled": True, "privacy_controls": True, "audit_logging": True},
    }
    f = tempfile.NamedTemporaryFile(mode="w", suffix=".json", delete=False)
    json.dump(data, f)
    f.close()
    return f.name


def test_free_core_access():
    policy = UniversalFreeAIPolicy(make_policy())
    decision = policy.authorize(authenticated=True, safety_ok=True)
    assert decision.allowed
    assert not policy.subscription_required()


def test_authentication_required():
    policy = UniversalFreeAIPolicy(make_policy())
    assert not policy.authorize(authenticated=False, safety_ok=True).allowed


def test_safety_required():
    policy = UniversalFreeAIPolicy(make_policy())
    assert not policy.authorize(authenticated=True, safety_ok=False).allowed


def test_provider_authorization_required():
    policy = UniversalFreeAIPolicy(make_policy())
    assert not policy.authorize(authenticated=True, safety_ok=True, provider_authorized=False).allowed
