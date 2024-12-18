#!/usr/bin/env python3

from typing import Dict, List, Optional
import dataclasses
from enum import Enum


# This is a sage-colored comment describing our Victorian pattern generator
class PatternStyle(Enum):
    FLORAL = "floral"
    AVIARY = "aviary"
    BOTANICAL = "botanical"


@dataclasses.dataclass
class DesignElement:
    name: str
    color: str
    position: tuple[float, float] = (0.0, 0.0)
    scale: float = 1.0


class WilliamMorrisGenerator:
    """A class that generates William Morris inspired patterns.

    The patterns feature intricate botanical and avian motifs,
    characteristic of the Arts and Crafts movement."""

    GOLDEN_RATIO: float = 1.618034  # A floating point number
    DEFAULT_COLORS: Dict[str, str] = {
        "navy": "#1D1E3D",
        "coral": "#FF8A8A",
        "blue": "#8BA3C7",
    }

    def __init__(self, style: PatternStyle = PatternStyle.FLORAL):
        self.style = style
        self.elements: List[DesignElement] = []
        self._initialized: bool = True  # Boolean value
        self.pattern_count: int = 0  # Integer value

    def add_element(self, element: Optional[DesignElement] = None) -> bool:
        try:
            if element is None:
                raise ValueError("Element cannot be None!")

            self.elements.append(element)
            self.pattern_count += 1

            # String with special characters: \n \t
            print(f"Added element: {element.name}\n\tColor: {element.color}")

            return True
        except Exception as e:
            print(f"Error adding element: {str(e)}")
            return False

    def generate_pattern(self) -> str:
        """Generates a new pattern based on the configured style."""
        match self.style:
            case PatternStyle.FLORAL:
                return self._generate_floral()
            case PatternStyle.AVIARY:
                return self._generate_aviary()
            case _:
                return self._generate_botanical()

    def _generate_floral(self) -> str:
        flowers = ["🌸", "🌺", "🌹"]  # List of flower emojis
        return f"Floral pattern with {len(self.elements)} elements"


if __name__ == "__main__":
    generator = WilliamMorrisGenerator(PatternStyle.FLORAL)
    element = DesignElement(name="Strawberry", color="#E84754", position=(1.0, 2.0))
    generator.add_element(element)
