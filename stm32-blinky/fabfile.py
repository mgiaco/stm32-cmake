from fabric.api import *
from fabric.context_managers import lcd
import fabric.contrib.project as project
import os
import shutil
import sys

# Local path configuration (can be absolute or relative to fabfile)
env.build_path = 'build_cm3'
BUILD_PATH = env.build_path


def clean():
	if os.path.isdir(BUILD_PATH):
		with lcd(BUILD_PATH):
			local('make clean -j4')


def clean_all():
    if os.path.isdir(BUILD_PATH):
    	shutil.rmtree(BUILD_PATH, ignore_errors=True)
        #local('rmdir /s /q {build_path}'.format(**env))


def configure():
		if not os.path.exists(BUILD_PATH):
			os.mkdir(BUILD_PATH)
			#local('mkdir ' + BUILD_PATH)
			with lcd(BUILD_PATH):
				local('cmake.exe -G "MinGW Makefiles" -C ../../build_settings.cmake -DCMAKE_BUILD_TYPE=Debug ../')

def all():
	if not os.path.exists(BUILD_PATH):
		configure()

	with lcd(BUILD_PATH):
		local('make -j4 all')


def make():
	with lcd(BUILD_PATH):
		local('make -j4')


def build():
    all()

def rebuild():
    clean()
    all()

def rebuild_all():
	clean_all()
	all()

