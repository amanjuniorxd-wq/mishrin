"""Policy enforcement for AI services controlled by the project.

This module deliberately does not bypass provider authentication, pricing,
licensing, rate limits, or security controls.
"""
from dataclasses import dataclass
from pathlib import Path
import json


@dataclass(frozen=True)
class AccessDecision:
    allowed: bool
    reason: str


class UniversalFreeAIPolicy:
    def __init__(self, policy_path: str | Path = "policy/universal_free_ai.json"):
        self.policy = json.loads(Path(policy_path).read_text(encoding="utf-8"))

    def authorize(self, *, authenticated: bool, safety_ok: bool,
                  provider_authorized: bool = True) -> AccessDecision:
        if not authenticated:
            return AccessDecision(False, "authentication_required")
        if not safety_ok:
            return AccessDecision(False, "safety_policy_denied")
        if not provider_authorized:
            return AccessDecision(False, "provider_authorization_required")
        return AccessDecision(True, "free_core_access")

    def subscription_required(self) -> bool:
        return bool(self.policy["subscription_required"])
