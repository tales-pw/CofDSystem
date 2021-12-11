import importlib
import os
from typing import Dict, Tuple, Any, Optional, Union, List

TreeModule = Dict[str, Union["TreeModule", str]]


class Tree:
    tree: TreeModule

    def __init__(self):
        self.tree = {}

    def _ensure_package(self, package_name: str) -> Optional[Dict]:
        package = self.tree
        for part in package_name.split("."):
            if part.startswith("_"):
                return

            if part in package:
                package = package[part]
                continue

            package_name = {}
            package[part] = package_name
            package = package_name

        return package

    def get_tree_module(self) -> TreeModule:
        return self.tree

    def put(self, package_name, hx_clazz_name, python_clazz_name) -> None:
        package = self._ensure_package(package_name)

        if package is None:
            return

        package[hx_clazz_name] = python_clazz_name

    @staticmethod
    def has_submodules(tree_module: TreeModule) -> bool:
        for child in tree_module.values():
            if isinstance(child, dict):
                return True

        return False

    @staticmethod
    def get_package_clazz(full_name: str) -> Tuple[str, str]:
        if "." in full_name:
            package, clazz_name = full_name.rsplit(".", 1)
            return package, clazz_name

        return "", full_name

    @classmethod
    def create(cls, module: Any, matching_package: str) -> "Tree":
        members: Dict = module.__dict__["_hx_classes"]

        tree = Tree()

        for full_name, clazz in members.items():
            if not full_name.startswith(matching_package):
                continue

            full_name: str
            full_name = full_name.removeprefix(matching_package)
            package, clazz_name = cls.get_package_clazz(full_name)
            tree.put(package, clazz_name, clazz.__name__)

        return tree


class Generator:
    def __init__(self, tree: Tree, output_path: str):
        self.tree = tree
        self.output_path = output_path

    @staticmethod
    def generate_file_module(
        filename: str,
        dirs: List[str],
        tree_module: TreeModule,
    ):
        file_value = "from CofDSystem.haxe_build import haxe_build\n"

        for key, value in tree_module.items():
            if isinstance(value, dict):
                continue

            file_value += f"\n{key} = haxe_build.{value}"

        file_value += "\n"

        with open(os.path.join(*[*dirs, filename]), "w") as file:
            file.write(file_value)

    @classmethod
    def generate_module(cls, dirs: List[str], tree_module: TreeModule):
        os.makedirs(os.path.join(*dirs), exist_ok=True)

        cls.generate_file_module("__init__.py", dirs, tree_module)

        for key, value in tree_module.items():
            if not isinstance(value, dict):
                continue

            if Tree.has_submodules(value):
                cls.generate_module([*dirs, key], value)
            else:
                cls.generate_file_module(f"{key}.py", dirs, value)

    def generate(self) -> None:
        tree_module = self.tree.get_tree_module()
        self.generate_module([self.output_path], tree_module)

    @classmethod
    def create(cls, module: Any, output_path: str, package_name: str):
        tree = Tree.create(module, package_name)
        return Generator(tree, output_path)


def generate_modules(output_path: str):
    module = importlib.import_module("haxe_build")
    Generator.create(module, output_path, "pw.tales.cofdsystem").generate()
