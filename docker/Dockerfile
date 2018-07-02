FROM node:6

# Create app directory
WORKDIR /usr/src/app

# Install system dependencies
RUN apt-get update && apt-get install -y libzmq3-dev cron supervisor

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY ./package*.json ./

# If you are building your code for production
# RUN npm install --only=production

RUN npm install

# Bundle app source
COPY . .

# supervisor config to keep cron and explorer running
COPY ./docker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# install crontab
RUN (crontab -l ; echo "*/1 * * * * cd /usr/src/app && /usr/local/bin/nodejs scripts/sync.js index update > /dev/null 2>&1") | crontab
RUN (crontab -l ; echo "*/2 * * * * cd /usr/src/app && /usr/local/bin/nodejs scripts/sync.js market > /dev/null 2>&1") | crontab
RUN (crontab -l ; echo "*/5 * * * * cd /usr/src/app && /usr/local/bin/nodejs scripts/peers.js > /dev/null 2>&1") | crontab

# If you get problems with stuck sync try this hack
#RUN (crontab -l ; echo "*/15 * * * * rm /usr/src/app/tmp/index.pid") | crontab

COPY ./docker/entrypoint.sh /entrypoint.sh

# explorer
EXPOSE 3030

# zmq publisher port
EXPOSE 30611

ENTRYPOINT ["/entrypoint.sh"]

CMD [ "supervisord", "-n" ]
